module Main
where

import Prelude
import Leaflet as L
import Leaflet (LEAFLET)
import Control.Monad.Eff (Eff)

main :: forall eff. Eff (leaflet :: LEAFLET | eff) Unit
main = do
  m <- L.map "mymap" (L.latlng 50.0 0.0) 10
  tiles <- L.tileLayer
            "//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
            [ L.TileLayerMinZoom 9
            , L.TileLayerMaxZoom 11
            , L.TileLayerSubdomains [ "a", "b", "c" ]
            , L.TileLayerBounds
                (L.latLngBounds
                  (L.latlng 49.0 (-1.0))
                  (L.latlng 51.0 1.0))
            ]
  L.addLayer tiles m
