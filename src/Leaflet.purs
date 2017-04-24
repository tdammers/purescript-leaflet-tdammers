module Leaflet
( LEAFLET
, Map
, map
, Layer
, tileLayer
, addLayer
, TileLayerOption (..)
, LatLng
, Latitude
, Longitude
, Zoom
, Point
, Pixels
, MouseEvent
, UrlTemplate
, latlng
, lat, lng
, getZoom
, getCenter
, setView
, invalidateSize
, onZoom
, onMove
, onClick
, onDblClick
, onMouseMove
, onMouseOver
, onMouseOut
, onMouseUp
, onMouseDown
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

-- | A map object (http://leafletjs.com/reference-1.0.3.html#map-example)
foreign import data Map :: Type

-- | A map layer
foreign import data Layer :: Type

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

-- | Metadata for a mouse event.
type MouseEvent =
      { latlng :: LatLng -- ^ Mouse position in geocoordinate space
      , layerPoint :: Point -- ^ Mouse position relative to the layers
      , containerPoint :: Point -- ^ Mouse position relative to the container element
      }

-- | A URL template for tile layers.
type UrlTemplate = String

-- | `map domID latLng zoom` creates a new map object centered at `latLng`, at
-- | zoom level `zoom`, and attaches it to the DOM element with ID `domID`.
foreign import map :: forall e
                      . String
                     -> LatLng
                     -> Zoom
                     -> Eff (leaflet :: LEAFLET | e) Map

-- | `tileLayer template` creates a new
-- | [tile layer](http://leafletjs.com/reference-1.0.3.html#tilelayer) using
-- | the URL template `template` to generate tile URLS.
-- |
-- | The template can use the following variables, written between curly
-- | braces:
-- | - `{z}`: zoom level
-- | - `{x}`, `{y}`: the tile coordinates (after projection), from the range
-- |   `[0..(2 ^ z))`
-- | - `{s}`: subdomain
-- |
-- | Example: `"http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"`
foreign import tileLayerJS :: forall e
                            . UrlTemplate
                           -> TileLayerOptions
                           -> Eff (leaflet :: LEAFLET | e) Layer

foreign import mkTileLayerOptionsJS :: (forall a. Tuple String a -> String)
                                    -> (forall b. Tuple b OptVal -> OptVal)
                                    -> Array (Tuple String OptVal)
                                    -> TileLayerOptions

mkTileLayerOptions :: Array TileLayerOption -> TileLayerOptions
mkTileLayerOptions optlist =
  mkTileLayerOptionsJS fst snd $ P.map toTileLayerOptionJS optlist
                                    
foreign import data TileLayerOptions :: Type
foreign import data OptVal :: Type

foreign import optValStr :: String -> OptVal
foreign import optValNumber :: Number -> OptVal
foreign import optValInt :: Int -> OptVal
foreign import optValBoolean :: Boolean -> OptVal

data TileLayerOption
  = TileLayerMinZoom Int
  | TileLayerMaxZoom Int
  | TileLayerTileSize Int
  | TileLayerOpacity Number
  | TileLayerUpdateWhenZooming Boolean
  | TileLayerUpdateInterval Number
  | TileLayerZIndex Int

toTileLayerOptionJS :: TileLayerOption -> Tuple String OptVal
toTileLayerOptionJS = case _ of
  TileLayerMinZoom z -> Tuple "minZoom" (optValInt z)
  TileLayerMaxZoom z -> Tuple "maxZoom" (optValInt z)
  TileLayerTileSize z -> Tuple "tileSize" (optValInt z)
  TileLayerOpacity z -> Tuple "opacity" (optValNumber z)
  TileLayerUpdateWhenZooming z -> Tuple "updateWhenZooming" (optValBoolean z)
  TileLayerUpdateInterval z -> Tuple "updateInterval" (optValNumber z)
  TileLayerZIndex z -> Tuple "zIndex" (optValInt z)

tileLayer :: forall e
          . UrlTemplate
         -> Array TileLayerOption
         -> Eff (leaflet :: LEAFLET | e) Layer
tileLayer url optionList = do
  let options = mkTileLayerOptions optionList
  tileLayerJS url options

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
