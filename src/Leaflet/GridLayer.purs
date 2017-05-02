module Leaflet.GridLayer
( Option (..)
, gridSize
, opacity
, updateWhenIdle
, updateWhenZooming
, updateInterval
, zIndex
, bounds
, noWrap
, pane
, className
, keepBuffer
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
import Data.Maybe (Maybe (..))
import Leaflet.Layer (Layer)
import Leaflet.Layer as Layer

-- | Options to be passed to a tile layer at construction time. See
-- | http://leafletjs.com/reference-1.0.3.html#tilelayer for an explanation of
-- | each option.
data Option
  = GridSize Int
  | Opacity Number
  | UpdateWhenIdle Boolean
  | UpdateWhenZooming Boolean
  | UpdateInterval Number
  | ZIndex Int
  | Bounds LatLngBounds
  | NoWrap Boolean
  | Pane String
  | ClassName String
  | KeepBuffer Int
  | LayerOption Layer.Option

gridSize :: Int -> Option
gridSize = GridSize 
opacity :: Number -> Option
opacity = Opacity 
updateWhenIdle :: Boolean -> Option
updateWhenIdle = UpdateWhenIdle 
updateWhenZooming :: Boolean -> Option
updateWhenZooming = UpdateWhenZooming 
updateInterval :: Number -> Option
updateInterval = UpdateInterval 
zIndex :: Int -> Option
zIndex = ZIndex 
bounds :: LatLngBounds -> Option
bounds = Bounds 
noWrap :: Boolean -> Option
noWrap = NoWrap 
pane :: String -> Option
pane = Pane 
className :: String -> Option
className = ClassName 
keepBuffer :: Int -> Option
keepBuffer = KeepBuffer 

layerOption :: Layer.Option -> Option
layerOption = LayerOption 

attribution :: String -> Option
attribution = layerOption <<< Layer.attribution

instance isOptionGridLayerOption :: IsOption Option where
  toOption = case _ of
    GridSize z -> mkOption "tileSize" z
    Opacity z -> mkOption "opacity" z
    UpdateWhenIdle z -> mkOption "updateWhenIdle" z
    UpdateWhenZooming z -> mkOption "updateWhenZooming" z
    UpdateInterval z -> mkOption "updateInterval" z
    ZIndex z -> mkOption "zIndex" z
    Bounds z -> mkOption "bounds" z
    NoWrap z -> mkOption "noWrap" z
    Pane z -> mkOption "pane" z
    ClassName z -> mkOption "className" z
    KeepBuffer z -> mkOption "keepBuffer" z
    LayerOption o -> toOption o
