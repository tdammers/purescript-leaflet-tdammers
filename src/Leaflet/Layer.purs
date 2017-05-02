module Leaflet.Layer
( Layer
, Option (..)
, attribution
, class IsLayer
, toLayer
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

-- | Options to be passed to a layer at construction time. See
-- | http://leafletjs.com/reference-1.0.3.html#layer for an explanation of
-- | each option.
data Option
  = Attribution String

-- | A map layer
foreign import data Layer :: Type

attribution :: String -> Option
attribution = Attribution

instance isOptionLayerOption :: IsOption Option where
  toOption = case _ of
    Attribution z -> mkOption "attribution" z

class IsLayer a where
  toLayer :: a -> Layer

instance isLayerLayer :: IsLayer Layer where
  toLayer = id
