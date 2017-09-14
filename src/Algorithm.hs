{-# LANGUAGE DataKinds, DefaultSignatures, GADTs, RankNTypes, ScopedTypeVariables, TypeOperators #-}
module Algorithm where

import Control.Applicative (liftA2)
import Control.Monad (guard, join)
import Control.Monad.Free.Freer
import Data.Function (on)
import Data.Functor.Classes
import Data.List.NonEmpty (NonEmpty(..))
import Data.Maybe
import Data.Proxy
import Data.These
import Data.Union
import Diff
import GHC.Generics
import Term

-- | A single step in a diffing algorithm, parameterized by the types of terms, diffs, and the result of the applicable algorithm.
data AlgorithmF term diff ann1 ann2 result where
  -- | Diff two terms with the choice of algorithm left to the interpreter’s discretion.
  Diff :: term ann -> term ann -> AlgorithmF term diff ann ann (diff ann)
  -- | Diff two terms recursively in O(n) time, resulting in a single diff node.
  Linear :: term ann -> term ann -> AlgorithmF term diff ann ann (diff ann)
  -- | Diff two lists of terms by each element’s similarity in O(n³ log n), resulting in a list of diffs.
  RWS :: [term ann] -> [term ann] -> AlgorithmF term diff ann ann [diff ann]
  -- | Delete a term..
  Delete :: term ann -> AlgorithmF term diff ann ann (diff ann)
  -- | Insert a term.
  Insert :: term ann -> AlgorithmF term diff ann ann (diff ann)
  -- | Replace one term with another.
  Replace :: term ann -> term ann -> AlgorithmF term diff ann ann (diff ann)

-- | The free applicative for 'AlgorithmF'. This enables us to construct diff values using <$> and <*> notation.
type Algorithm term diff ann1 ann2 = Freer (AlgorithmF term diff ann1 ann2)


-- DSL

-- | Diff two terms without specifying the algorithm to be used.
diff :: term ann -> term ann -> Algorithm term diff ann ann (diff ann)
diff = (liftF .) . Algorithm.Diff

-- | Diff a These of terms without specifying the algorithm to be used.
diffThese :: These (term ann) (term ann) -> Algorithm term diff ann ann (diff ann)
diffThese = these byDeleting byInserting diff

-- | Diff a pair of optional terms without specifying the algorithm to be used.
diffMaybe :: Maybe (term ann) -> Maybe (term ann) -> Algorithm term diff ann ann (Maybe (diff ann))
diffMaybe a b = case (a, b) of
  (Just a, Just b) -> Just <$> diff a b
  (Just a, _) -> Just <$> byDeleting a
  (_, Just b) -> Just <$> byInserting b
  _ -> pure Nothing

-- | Diff two terms linearly.
linearly :: term ann -> term ann -> Algorithm term diff ann ann (diff ann)
linearly a b = liftF (Linear a b)

-- | Diff two terms using RWS.
byRWS :: [term ann] -> [term ann] -> Algorithm term diff ann ann [diff ann]
byRWS a b = liftF (RWS a b)

-- | Delete a term.
byDeleting :: term ann -> Algorithm term diff ann ann (diff ann)
byDeleting = liftF . Delete

-- | Insert a term.
byInserting :: term ann -> Algorithm term diff ann ann (diff ann)
byInserting = liftF . Insert

-- | Replace one term with another.
byReplacing :: term ann -> term ann -> Algorithm term diff ann ann (diff ann)
byReplacing = (liftF .) . Replace


instance (Show1 term, Show ann) => Show1 (AlgorithmF term diff ann ann) where
  liftShowsPrec _ _ d algorithm = case algorithm of
    Algorithm.Diff t1 t2 -> showsBinaryWith showsTerm showsTerm "Diff" d t1 t2
    Linear t1 t2 -> showsBinaryWith showsTerm showsTerm "Linear" d t1 t2
    RWS as bs -> showsBinaryWith (liftShowsPrec showsTerm (liftShowList showsPrec showList)) (liftShowsPrec showsTerm (liftShowList showsPrec showList)) "RWS" d as bs
    Delete t1 -> showsUnaryWith showsTerm "Delete" d t1
    Insert t2 -> showsUnaryWith showsTerm "Insert" d t2
    Replace t1 t2 -> showsBinaryWith showsTerm showsTerm "Replace" d t1 t2
    where showsTerm :: Int -> term ann -> ShowS
          showsTerm = liftShowsPrec showsPrec showList


-- | Diff two terms based on their generic Diffable instances. If the terms are not diffable
-- (represented by a Nothing diff returned from algorithmFor) replace one term with another.
algorithmForTerms :: (Functor f, Diffable f) => Term f a -> Term f a -> Algorithm (Term f) (Diff f) a a (Diff f a)
algorithmForTerms t1 t2 = fromMaybe (byReplacing t1 t2) (algorithmForComparableTerms t1 t2)

algorithmForComparableTerms :: (Functor f, Diffable f) => Term f a -> Term f a -> Maybe (Algorithm (Term f) (Diff f) a a (Diff f a))
algorithmForComparableTerms (Term (In ann1 f1)) (Term (In ann2 f2)) = fmap (merge (ann1, ann2)) <$> algorithmFor f1 f2


-- | A type class for determining what algorithm to use for diffing two terms.
class Diffable f where
  algorithmFor :: f (term ann) -> f (term ann) -> Maybe (Algorithm term diff ann ann (f (diff ann)))
  default algorithmFor :: (Generic1 f, Diffable' (Rep1 f)) => f (term ann) -> f (term ann) -> Maybe (Algorithm term diff ann ann (f (diff ann)))
  algorithmFor = genericAlgorithmFor

genericAlgorithmFor :: (Generic1 f, Diffable' (Rep1 f)) => f (term ann) -> f (term ann) -> Maybe (Algorithm term diff ann ann (f (diff ann)))
genericAlgorithmFor a b = fmap to1 <$> algorithmFor' (from1 a) (from1 b)


-- | Diff a Union of Syntax terms. Left is the "rest" of the Syntax terms in the Union,
-- Right is the "head" of the Union. 'weaken' relaxes the Union to allow the possible
-- diff terms from the "rest" of the Union, and 'inj' adds the diff terms into the Union.
-- NB: If Left or Right Syntax terms in our Union don't match, we fail fast by returning Nothing.
instance Apply1 Diffable fs => Diffable (Union fs) where
  algorithmFor u1 u2 = join (apply1_2' (Proxy :: Proxy Diffable) (\ reinj f1 f2 -> fmap reinj <$> algorithmFor f1 f2) u1 u2)

-- | Diff two list parameters using RWS.
instance Diffable [] where
  algorithmFor a b = Just (byRWS a b)

-- | A generic type class for diffing two terms defined by the Generic1 interface.
class Diffable' f where
  algorithmFor' :: f (term ann) -> f (term ann) -> Maybe (Algorithm term diff ann ann (f (diff ann)))

-- | Diff two constructors (M1 is the Generic1 newtype for meta-information (possibly related to type constructors, record selectors, and data types))
instance Diffable' f => Diffable' (M1 i c f) where
  algorithmFor' (M1 a) (M1 b) = fmap M1 <$> algorithmFor' a b

-- | Diff the fields of a product type.
-- i.e. data Foo a b = Foo a b (the 'Foo a b' is captured by 'a :*: b').
instance (Diffable' f, Diffable' g) => Diffable' (f :*: g) where
  algorithmFor' (a1 :*: b1) (a2 :*: b2) = liftA2 (:*:) <$> algorithmFor' a1 a2 <*> algorithmFor' b1 b2

-- | Diff the constructors of a sum type.
-- i.e. data Foo a = Foo a | Bar a (the 'Foo a' is captured by L1 and 'Bar a' is R1).
instance (Diffable' f, Diffable' g) => Diffable' (f :+: g) where
  algorithmFor' (L1 a) (L1 b) = fmap L1 <$> algorithmFor' a b
  algorithmFor' (R1 a) (R1 b) = fmap R1 <$> algorithmFor' a b
  algorithmFor' _ _ = Nothing

-- | Diff two parameters (Par1 is the Generic1 newtype representing a type parameter).
-- i.e. data Foo a = Foo a (the 'a' is captured by Par1).
instance Diffable' Par1 where
  algorithmFor' (Par1 a) (Par1 b) = Just (Par1 <$> linearly a b)

-- | Diff two constant parameters (K1 is the Generic1 newtype representing type parameter constants).
-- i.e. data Foo = Foo Int (the 'Int' is a constant parameter).
instance Eq c => Diffable' (K1 i c) where
  algorithmFor' (K1 a) (K1 b) = guard (a == b) *> Just (pure (K1 a))

-- | Diff two terms whose constructors contain 0 type parameters.
-- i.e. data Foo = Foo.
instance Diffable' U1 where
  algorithmFor' _ _ = Just (pure U1)

-- | Diff two lists of parameters.
instance Diffable' (Rec1 []) where
  algorithmFor' a b = fmap Rec1 <$> Just ((byRWS `on` unRec1) a b)

-- | Diff two non-empty lists of parameters.
instance Diffable' (Rec1 NonEmpty) where
  algorithmFor' (Rec1 (a:|as)) (Rec1 (b:|bs)) = Just $ do
    d:ds <- byRWS (a:as) (b:bs)
    pure (Rec1 (d :| ds))
