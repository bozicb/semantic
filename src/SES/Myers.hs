{-# LANGUAGE BangPatterns, GADTs, ImplicitParams, MultiParamTypeClasses, ScopedTypeVariables #-}
module SES.Myers
( EditScript
, ses
) where

import Data.Array ((!))
import qualified Data.Array as Array
import Data.Ix
import Data.These
import GHC.Show hiding (show)
import Prologue hiding (error)

-- | An edit script, i.e. a sequence of changes/copies of elements.
type EditScript a b = [These a b]

data Endpoint a b = Endpoint { x :: {-# UNPACK #-} !Int, _y :: {-# UNPACK #-} !Int, _script :: EditScript a b }
  deriving (Eq, Show)


-- | Compute the shortest edit script using Myers’ algorithm.
ses :: (Foldable t, Foldable u) => (a -> b -> Bool) -> t a -> u b -> EditScript a b
ses eq as' bs'
  | null bs = This <$> toList as
  | null as = That <$> toList bs
  | otherwise = reverse (searchUpToD 0 (Array.array (1, 1) [(1, Endpoint 0 (-1) [])]))
  where (as, bs) = (Array.listArray (0, pred n) (toList as'), Array.listArray (0, pred m) (toList bs'))
        (!n, !m) = (length as', length bs')

        -- Search an edit graph for the shortest edit script up to a given proposed edit distance, building on the results of previous searches.
        searchUpToD !d !v =
          let endpoints = slideFrom . searchAlongK <$> [ k | k <- [-d, -d + 2 .. d], inRange (-m, n) k ] in
          case find isComplete endpoints of
            Just (Endpoint _ _ script) -> script
            _ -> searchUpToD (succ d) (Array.array (-d, d) ((\ e@(Endpoint x y _) -> (x - y, e)) <$> endpoints))
          where isComplete (Endpoint x y _) = x >= n && y >= m

                -- Search an edit graph for the shortest edit script along a specific diagonal, moving onto a given diagonal from one of its in-bounds adjacent diagonals (if any).
                searchAlongK !k
                  | k == -d = moveDownFrom (v ! succ k)
                  | k ==  d = moveRightFrom (v ! pred k)
                  | k == -m = moveDownFrom (v ! succ k)
                  | k ==  n = moveRightFrom (v ! pred k)
                  | otherwise =
                    let left = v ! pred k
                        up   = v ! succ k in
                    if x left < x up then
                      moveDownFrom up
                    else
                      moveRightFrom left

        -- | Move downward from a given vertex, inserting the element for the corresponding row.
        moveDownFrom  (Endpoint x y script) = Endpoint       x (succ y) (if y >= 0 && y < m then That (bs ! y) : script else script)

        -- | Move rightward from a given vertex, deleting the element for the corresponding column.
        moveRightFrom (Endpoint x y script) = Endpoint (succ x)      y  (if x < n then This (as ! x) : script else script)

        -- | Slide down any diagonal edges from a given vertex.
        slideFrom (Endpoint x y script)
          | inRange (Array.bounds as) x, a <- as ! x
          , inRange (Array.bounds bs) y, b <- bs ! y
          , a `eq` b  = slideFrom (Endpoint (succ x) (succ y) (These a b : script))
          | otherwise =            Endpoint       x        y               script
