-- | Basic types for Leaflet maps.
module Leaflet.Types
( LEAFLET
, Zoom
, Pixels
, Point
)
where

import Prelude ( Unit
               , class Show
               , show
               , (<>)
               , id
               , (<<<)
               , ($)
               )
import Prelude as P
import Control.Monad.Eff
import Data.Array as Array
import Data.Tuple (Tuple (..), fst, snd)

-- | Anything that uses Leaflet has a `LEAFLET` effect.
foreign import data LEAFLET :: Effect

-- | A zoom level. Zoom levels start at 0 (which means "show the whole world")
-- | and zoom in exponentially, each step corresponding to a factor of 2.
type Zoom = Int

-- | A distance in screen space, measured in logical pixels ("CSS Pixels").
type Pixels = Number

-- | A point in 2D screen space.
type Point = { x :: Pixels, y :: Pixels }

