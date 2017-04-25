-- | Basic types for Leaflet maps.
module Leaflet.Types
( LEAFLET
, Latitude
, Longitude
, LatLng
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

-- | Geographic latitude
type Latitude = Number

-- | Geographic longitude
type Longitude = Number

-- | Latitude / longitude pair. Leaflet.js accepts these in various flavors,
-- | but we only expose this one type.
type LatLng =
  { lat :: Latitude, lng :: Longitude }

-- | Construct a `LatLng` record from separate components
latlng :: Latitude -> Longitude -> LatLng
latlng lat lng = { lat, lng }

-- | Extract the latitude from a `LatLng`
lat :: LatLng -> Latitude
lat = _.lat

-- | Extract the longitude from a `LatLng`
lng :: LatLng -> Longitude
lng = _.lng

-- | A zoom level. Zoom levels start at 0 (which means "show the whole world")
-- | and zoom in exponentially, each step corresponding to a factor of 2.
type Zoom = Int

-- | A distance in screen space, measured in logical pixels ("CSS Pixels").
type Pixels = Number

-- | A point in 2D screen space.
type Point = { x :: Pixels, y :: Pixels }

