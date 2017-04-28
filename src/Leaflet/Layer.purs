module Leaflet.Layer
( Option (..)
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

-- | Options to be passed to a layer at construction time. See
-- | http://leafletjs.com/reference-1.0.3.html#layer for an explanation of
-- | each option.
data Option
  = Attribution String

attribution :: String -> Option
attribution = Attribution

instance isOptionLayerOption :: IsOption Option where
  toOption = case _ of
    Attribution z -> mkOption "attribution" z
