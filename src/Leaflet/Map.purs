module Leaflet.Map
( Layer
, Map
, MouseEvent
, addLayer
, getCenter
, getZoom
, invalidateSize
, map
, onClick
, onDblClick
, onMouseDown
, onMouseEvent
, onMouseMove
, onMouseOut
, onMouseOver
, onMouseUp
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

-- | A map object (http://leafletjs.com/reference-1.0.3.html#map-example)
foreign import data Map :: Type

-- | A map layer
foreign import data Layer :: Type

-- | Metadata for a mouse event.
type MouseEvent =
      { latlng :: LatLng -- ^ Mouse position in geocoordinate space
      , layerPoint :: Point -- ^ Mouse position relative to the layers
      , containerPoint :: Point -- ^ Mouse position relative to the container element
      }

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

-- | Subscribe to a mouse even by name.
foreign import onMouseEvent :: forall e
                             . String
                            -> Map
                            -> (MouseEvent -> e Unit)
                            -> e Unit

-- | Subscribe to the `mousemove` event
onMouseMove :: forall e
             . Map
            -> (MouseEvent -> e Unit)
            -> e Unit
onMouseMove = onMouseEvent "mousemove"

-- | Subscribe to the `mouseover` event
onMouseOver :: forall e
             . Map
            -> (MouseEvent -> e Unit)
            -> e Unit
onMouseOver = onMouseEvent "mouseover"

-- | Subscribe to the `mouseout` event
onMouseOut :: forall e
            . Map
           -> (MouseEvent -> e Unit)
           -> e Unit
onMouseOut = onMouseEvent "mouseout"

-- | Subscribe to the `mouseup` event (mouse button pressed)
onMouseUp :: forall e
           . Map
          -> (MouseEvent -> e Unit)
          -> e Unit
onMouseUp = onMouseEvent "mouseup"

-- | Subscribe to the `mousedown` event (mouse button released)
onMouseDown :: forall e
             . Map
            -> (MouseEvent -> e Unit)
            -> e Unit
onMouseDown = onMouseEvent "mousedown"

-- | Subscribe to the `click` event
onClick :: forall e
         . Map
        -> (MouseEvent -> e Unit)
        -> e Unit
onClick = onMouseEvent "click"

-- | Subscribe to the `dblclick` event (double click)
onDblClick :: forall e
            . Map
           -> (MouseEvent -> e Unit)
           -> e Unit
onDblClick = onMouseEvent "dblclick"
