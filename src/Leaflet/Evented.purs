module Leaflet.Evented
where

import Prelude
import Control.Monad.Eff (Eff)
import Leaflet.Types (LEAFLET)

class Evented t e h a | t -> e, t -> h where
  on:: forall eff
     . t
    -> a
    -> (e -> Eff (leaflet :: LEAFLET | eff) Unit)
    -> Eff (leaflet :: LEAFLET | eff) h
  off :: forall eff
       . t
      -> a
      -> h
      -> Eff (leaflet :: LEAFLET | eff) Unit
