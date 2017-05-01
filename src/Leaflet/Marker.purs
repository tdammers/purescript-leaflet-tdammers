module Leaflet.Marker
( marker
, Option (..)
, attribution
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
import Leaflet.Options
import Leaflet.Map (Layer, Map)
import Data.Maybe (Maybe (..))
import Leaflet.Layer as Layer

-- | A URL template for tile layers.
type UrlTemplate = String

foreign import markerJS :: forall e
                            . LatLng
                           -> Options
                           -> Eff (leaflet :: LEAFLET | e) Layer

-- | Options to be passed to a marker layer at construction time. See
-- | http://leafletjs.com/reference-1.0.3.html#marker for an explanation of
-- | each option.
data Option
  = Draggable Boolean
  | Keyboard Boolean
  | Title String
  | Alt String
  | ZIndexOffset Int
  | Opacity Number
  | RiseOnHover Boolean
  | RiseOffset Int
  | Pane String
-- | Icon Icon
  | LayerOption Layer.Option

draggable :: Boolean -> Option
draggable = Draggable

keyboard :: Boolean -> Option
keyboard = Keyboard

title :: String -> Option
title = Title

alt :: String -> Option
alt = Alt

zIndexOffset :: Int -> Option
zIndexOffset = ZIndexOffset

opacity :: Number -> Option
opacity = Opacity

riseOnHover :: Boolean -> Option
riseOnHover = RiseOnHover

riseOffset :: Int -> Option
riseOffset = RiseOffset

pane :: String -> Option
pane = Pane

layerOption :: Layer.Option -> Option
layerOption = LayerOption 

attribution :: String -> Option
attribution = layerOption <<< Layer.attribution

instance isOptionMarkerOption :: IsOption Option where
  toOption = case _ of
    Draggable x -> mkOption "draggable" x
    Keyboard x -> mkOption "keyboard" x
    Title x -> mkOption "title" x
    Alt x -> mkOption "alt" x
    ZIndexOffset x -> mkOption "zIndexOffset" x
    Opacity x -> mkOption "opacity" x
    RiseOnHover x -> mkOption "riseOnHover" x
    RiseOffset x -> mkOption "riseOffset" x
    Pane x -> mkOption "pane" x
    LayerOption o -> toOption o

-- | `marker position options` creates a new
-- | [marker](http://leafletjs.com/reference-1.0.3.html#marker) at the
-- | specified geographic coordinates.
-- |
marker :: forall e
          . LatLng
         -> Array Option
         -> Eff (leaflet :: LEAFLET | e) Layer
marker position optionList = do
  let options = mkOptions optionList
  markerJS position options


