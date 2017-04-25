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

-- | A URL template for tile layers.
type UrlTemplate = String

foreign import tileLayerJS :: forall e
                            . UrlTemplate
                           -> Options
                           -> Eff (leaflet :: LEAFLET | e) Layer

data TileLayerOption
  = TileLayerMinZoom Int
  | TileLayerMaxZoom Int
  | TileLayerTileSize Int
  | TileLayerOpacity Number
  | TileLayerUpdateWhenZooming Boolean
  | TileLayerUpdateInterval Number
  | TileLayerZIndex Int

instance isOptionTileLayerOption :: IsOption TileLayerOption where
  mkOption = case _ of
    TileLayerMinZoom z -> Tuple "minZoom" (optValInt z)
    TileLayerMaxZoom z -> Tuple "maxZoom" (optValInt z)
    TileLayerTileSize z -> Tuple "tileSize" (optValInt z)
    TileLayerOpacity z -> Tuple "opacity" (optValNumber z)
    TileLayerUpdateWhenZooming z -> Tuple "updateWhenZooming" (optValBoolean z)
    TileLayerUpdateInterval z -> Tuple "updateInterval" (optValNumber z)
    TileLayerZIndex z -> Tuple "zIndex" (optValInt z)

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

