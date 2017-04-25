module Leaflet.LatLng
( Latitude
, Longitude
, LatLng
, latlng
, lat
, lng
, LatLngBounds
, latLngBounds
, extendToPoint
, extendToBounds
, padLatLngBounds
, getCenter
, getNorthWest
, getSouthWest
, getNorthEast
, getSouthEast
, getNorth
, getSouth
, getWest
, getEast
, containsPoint
, contains
, intersects
, latLngBoundsEq
, toBBoxString
)
where

-- | Geographic latitude
type Latitude = Number

-- | Geographic longitude
type Longitude = Number

-- | Latitude / longitude pair. Leaflet.js accepts these in various flavors,
-- | but we only expose this one type.
foreign import data LatLng :: Type

-- | Construct a `LatLng` record from separate components
foreign import latlng :: Latitude -> Longitude -> LatLng

-- | Extract the latitude from a `LatLng`
foreign import lat :: LatLng -> Latitude

-- | Extract the longitude from a `LatLng`
foreign import lng :: LatLng -> Longitude

-- | Bounding rectangle in geo coordinate space.
foreign import data LatLngBounds :: Type

-- | Construct a `LatLngBounds` from two corners
foreign import latLngBounds :: LatLng -> LatLng -> LatLngBounds

foreign import extendToPoint :: LatLngBounds -> LatLng -> LatLngBounds
foreign import extendToBounds :: LatLngBounds -> LatLngBounds -> LatLngBounds
foreign import padLatLngBounds :: LatLngBounds -> Number -> LatLngBounds

foreign import getCenter :: LatLngBounds -> LatLng
foreign import getNorthWest :: LatLngBounds -> LatLng
foreign import getSouthWest :: LatLngBounds -> LatLng
foreign import getNorthEast :: LatLngBounds -> LatLng
foreign import getSouthEast :: LatLngBounds -> LatLng
foreign import getNorth :: LatLngBounds -> Latitude
foreign import getSouth :: LatLngBounds -> Latitude
foreign import getWest :: LatLngBounds -> Longitude
foreign import getEast :: LatLngBounds -> Longitude

foreign import containsPoint :: LatLngBounds -> LatLng -> Boolean
foreign import contains :: LatLngBounds -> LatLngBounds -> Boolean
foreign import intersects :: LatLngBounds -> LatLngBounds -> Boolean

foreign import latLngBoundsEq :: LatLngBounds -> LatLngBounds -> Boolean

foreign import toBBoxString :: LatLngBounds -> String
