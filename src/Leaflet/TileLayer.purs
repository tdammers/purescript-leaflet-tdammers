module Leaflet.TileLayer
( tileLayer
, UrlTemplate (..)
, TileLayerOption (..)
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

-- | A URL template for tile layers.
type UrlTemplate = String

foreign import tileLayerJS :: forall e
                            . UrlTemplate
                           -> Options
                           -> Eff (leaflet :: LEAFLET | e) Layer

-- | Options to be passed to a tile layer at construction time. See
-- | http://leafletjs.com/reference-1.0.3.html#tilelayer for an explanation of
-- | each option.
data TileLayerOption
  = TileLayerMinZoom Int
  | TileLayerMaxZoom Int
  | TileLayerMinNativeZoom (Maybe Int)
  | TileLayerMaxNativeZoom (Maybe Int)
  | TileLayerSubdomains (Array String)
  | TileLayerErrorTileUrl String
  | TileLayerZoomOffset Int
  | TileLayerTMS Boolean
  | TileLayerZoomReverse Boolean
  | TileLayerDetectRetina Boolean
  | TileLayerCrossOrigin Boolean
  -- inherited from GridLayer
  | TileLayerTileSize Int
  | TileLayerOpacity Number
  | TileLayerUpdateWhenIdle Boolean
  | TileLayerUpdateWhenZooming Boolean
  | TileLayerUpdateInterval Number
  | TileLayerZIndex Int
  | TileLayerBounds LatLngBounds
  | TileLayerNoWrap Boolean
  | TileLayerPane String
  | TileLayerClassName String
  | TileLayerKeepBuffer Int
  -- inherited from Layer
  | TileLayerAttribution String

instance isOptionTileLayerOption :: IsOption TileLayerOption where
  toOption = case _ of
    TileLayerMinZoom z -> mkOption "minZoom" z
    TileLayerMaxZoom z -> mkOption "maxZoom" z
    TileLayerMinNativeZoom z -> mkOption "minNativeZoom" z
    TileLayerMaxNativeZoom z -> mkOption "maxNativeZoom" z
    TileLayerSubdomains z -> mkOption "subdomains" z
    TileLayerErrorTileUrl z -> mkOption "errorTileUrl" z
    TileLayerZoomOffset z -> mkOption "zoomOffset" z
    TileLayerTMS z -> mkOption "tms" z
    TileLayerZoomReverse z -> mkOption "zoomReverse" z
    TileLayerDetectRetina z -> mkOption "detectRetina" z
    TileLayerCrossOrigin z -> mkOption "crossOrigin" z
    -- inherited from GridLayer
    TileLayerTileSize z -> mkOption "tileSize" z
    TileLayerOpacity z -> mkOption "opacity" z
    TileLayerUpdateWhenIdle z -> mkOption "updateWhenIdle" z
    TileLayerUpdateWhenZooming z -> mkOption "updateWhenZooming" z
    TileLayerUpdateInterval z -> mkOption "updateInterval" z
    TileLayerZIndex z -> mkOption "zIndex" z
    TileLayerBounds z -> mkOption "bounds" z
    TileLayerNoWrap z -> mkOption "noWrap" z
    TileLayerPane z -> mkOption "pane" z
    TileLayerClassName z -> mkOption "className" z
    TileLayerKeepBuffer z -> mkOption "keepBuffer" z
    -- inherited from Layer
    TileLayerAttribution z -> mkOption "attribution" z

-- | `tileLayer template options` creates a new
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
tileLayer :: forall e
          . UrlTemplate
         -> Array TileLayerOption
         -> Eff (leaflet :: LEAFLET | e) Layer
tileLayer url optionList = do
  let options = mkOptions optionList
  tileLayerJS url options

