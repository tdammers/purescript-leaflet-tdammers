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
  | TileLayerTileSize Int
  | TileLayerOpacity Number
  | TileLayerUpdateWhenZooming Boolean
  | TileLayerUpdateInterval Number
  | TileLayerZIndex Int
  | TileLayerSubdomains (Array String)

instance isOptionTileLayerOption :: IsOption TileLayerOption where
  toOption = case _ of
    TileLayerMinZoom z -> mkOption "minZoom" z
    TileLayerMaxZoom z -> mkOption "maxZoom" z
    TileLayerMinNativeZoom z -> mkOption "minNativeZoom" z
    TileLayerMaxNativeZoom z -> mkOption "maxNativeZoom" z
    TileLayerTileSize z -> mkOption "tileSize" z
    TileLayerOpacity z -> mkOption "opacity" z
    TileLayerUpdateWhenZooming z -> mkOption "updateWhenZooming" z
    TileLayerUpdateInterval z -> mkOption "updateInterval" z
    TileLayerZIndex z -> mkOption "zIndex" z
    TileLayerSubdomains z -> mkOption "subdomains" z

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

