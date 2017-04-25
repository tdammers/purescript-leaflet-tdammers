module Main
where

import Prelude
import Leaflet as L
import Leaflet (LEAFLET)
import Control.Monad.Eff (Eff)

main :: forall eff. Eff (leaflet :: LEAFLET | eff) Unit
main = do
  m <- L.map "mymap" { lat: 50.0, lng: 0.0 } 10
  tiles <- L.tileLayer
            "//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
            [ L.TileLayerMinZoom 9
            , L.TileLayerMaxZoom 11
            , L.TileLayerSubdomains [ "a", "b", "c" ]
            ]
  L.addLayer tiles m
