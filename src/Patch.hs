{-# LANGUAGE DeriveAnyClass #-}
{-# OPTIONS_GHC -funbox-strict-fields #-}
module Patch
( Patch(..)
, after
, before
, unPatch
, patchSum
, maybeFst
, maybeSnd
, mapPatch
) where

import Data.Aeson
import Data.Align
import Data.Functor.Classes.Eq.Generic
import Data.Functor.Classes.Pretty.Generic
import Data.Functor.Classes.Show.Generic
import Data.JSON.Fields
import Data.These
import GHC.Generics

-- | An operation to replace, insert, or delete an item.
data Patch a
  = Replace a a
  | Insert a
  | Delete a
  deriving (Eq, Foldable, Functor, Generic, Generic1, Ord, Show, Traversable)


-- | Return the item from the after side of the patch.
after :: Patch a -> Maybe a
after = maybeSnd . unPatch

-- | Return the item from the before side of the patch.
before :: Patch a -> Maybe a
before = maybeFst . unPatch

-- | Return both sides of a patch.
unPatch :: Patch a -> These a a
unPatch (Replace a b) = These a b
unPatch (Insert b) = That b
unPatch (Delete a) = This a

mapPatch :: (a -> b) -> (a -> b) -> Patch a -> Patch b
mapPatch f _ (Delete  a  ) = Delete  (f a)
mapPatch _ g (Insert    b) = Insert  (g b)
mapPatch f g (Replace a b) = Replace (f a) (g b)

-- | Calculate the cost of the patch given a function to compute the cost of a item.
patchSum :: (a -> Int) -> Patch a -> Int
patchSum termCost patch = maybe 0 termCost (before patch) + maybe 0 termCost (after patch)

-- | Return Just the value in This, or the first value in These, if any.
maybeFst :: These a b -> Maybe a
maybeFst = these Just (const Nothing) ((Just .) . const)

-- | Return Just the value in That, or the second value in These, if any.
maybeSnd :: These a b -> Maybe b
maybeSnd = these (const Nothing) Just ((Just .) . flip const)


-- Instances

instance Crosswalk Patch where
  crosswalk f (Replace a b) = alignWith (these Delete Insert Replace) (f a) (f b)
  crosswalk f (Insert b) = Insert <$> f b
  crosswalk f (Delete a) = Delete <$> f a

instance Eq1 Patch where liftEq = genericLiftEq
instance Show1 Patch where liftShowsPrec = genericLiftShowsPrec
instance Pretty1 Patch where liftPretty = genericLiftPretty

instance Pretty a => Pretty (Patch a) where
  pretty = liftPretty pretty prettyList


instance ToJSONFields a => ToJSONFields (Patch a) where
  toJSONFields (Insert a)    = [ "insert" .= object (toJSONFields a) ]
  toJSONFields (Delete a)    = [ "delete" .= object (toJSONFields a) ]
  toJSONFields (Replace a b) = [ "replace" .= [object (toJSONFields a), object (toJSONFields b)] ]
