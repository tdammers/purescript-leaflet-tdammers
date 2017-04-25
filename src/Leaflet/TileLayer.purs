module Leaflet.TileLayer
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
import Leaflet.Map (Layer, Map)

-- | A URL template for tile layers.
type UrlTemplate = String

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
  let options = mkTileLayerOptions optionList
  tileLayerJS url options

