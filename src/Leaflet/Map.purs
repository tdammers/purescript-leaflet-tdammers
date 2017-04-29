module Leaflet.Map
( Layer
, Map
, addLayer
, getCenter
, getZoom
, invalidateSize
, map
, onMove
, onZoom
, setView
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
import Leaflet.Types
import Leaflet.LatLng
import Leaflet.MouseInteraction

-- | A map object (http://leafletjs.com/reference-1.0.3.html#map-example)
foreign import data Map :: Type

-- | A map layer
foreign import data Layer :: Type

-- | `map domID latLng zoom` creates a new map object centered at `latLng`, at
-- | zoom level `zoom`, and attaches it to the DOM element with ID `domID`.
foreign import map :: forall e
                      . String
                     -> LatLng
                     -> Zoom
                     -> Eff (leaflet :: LEAFLET | e) Map

-- | Add a layer to a map
foreign import addLayer :: forall e
                           . Layer
                          -> Map
                          -> Eff (leaflet :: LEAFLET | e) Unit

-- | Set the current view for a map.
foreign import setView :: forall e
                        . Map
                       -> LatLng
                       -> Zoom
                       -> Eff (leaflet :: LEAFLET | e) Unit

-- | Tell a map that the size of its container may have changed, causing it to
-- recalculate its metrics and redraw itself.
foreign import invalidateSize :: forall e
                               . Map
                              -> Eff (leaflet :: LEAFLET | e) Unit

-- | Get the geographic position at which the map is currently centered.
foreign import getCenter :: forall e
                          . Map
                         -> Eff (leaflet :: LEAFLET | e) LatLng


-- | Get the current zoom level.
foreign import getZoom :: forall e
                        . Map
                       -> Eff (leaflet :: LEAFLET | e) Zoom

-- | Subscribe to the `zoom` event, which fires when the map's zoom level
-- | changes.
foreign import onZoom :: forall e
                       . Map
                      -> e Unit
                      -> e Unit

-- | Subscribe to the `move` event.
foreign import onMove :: forall e
                       . Map
                      -> (LatLng -> e Unit)
                      -> e Unit

-- | Subscribe to a mouse event by name.
foreign import onMouseEventJS :: forall e
                               . String
                              -> Map
                              -> (MouseEvent -> Eff e Unit)
                              -> Eff (leaflet :: LEAFLET | e) MouseEventHandle

-- | Unsubscribe from a mouse event by name.
foreign import offMouseEventJS :: forall e
                                . String
                               -> Map
                               -> MouseEventHandle
                               -> Eff (leaflet :: LEAFLET | e) Unit

instance mouseInteractionMap :: MouseInteraction Map where
  onMouseEvent = onMouseEventJS <<< mouseEventKey
  offMouseEvent = offMouseEventJS <<< mouseEventKey
