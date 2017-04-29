module Main
where

import Prelude
import Leaflet as L
import Leaflet.TileLayer as TileLayer
import Leaflet (LEAFLET)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)

main :: forall eff. Eff (leaflet :: LEAFLET, console :: CONSOLE | eff) Unit
main = do
  m <- L.map "mymap" (L.latlng 50.0 0.0) 10
  tiles <- L.tileLayer
            "//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
            [ TileLayer.minZoom 9
            , TileLayer.maxZoom 11
            , TileLayer.subdomains [ "a", "b", "c" ]
            , TileLayer.bounds
                (L.latLngBounds
                  (L.latlng 49.0 (-1.0))
                  (L.latlng 51.0 1.0))
            ]
  L.addLayer tiles m
  h <- L.on L.MouseMove m $ \(L.MouseEvent e) -> do
    log $ show [L.lat e.latlng, L.lng e.latlng]
  pure unit
