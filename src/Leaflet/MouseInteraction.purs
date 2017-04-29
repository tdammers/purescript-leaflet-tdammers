module Leaflet.MouseInteraction
where

import Prelude
import Leaflet.LatLng
import Leaflet.Types
import Control.Monad.Eff
import Data.Newtype

-- | Metadata for a mouse event.
newtype MouseEvent =
  MouseEvent
      { latlng :: LatLng -- ^ Mouse position in geocoordinate space
      , layerPoint :: Point -- ^ Mouse position relative to the layers
      , containerPoint :: Point -- ^ Mouse position relative to the container element
      }

derive instance newtypeMouseEvent :: Newtype MouseEvent _

foreign import data MouseEventHandle :: Type

data MouseEventType
  = MouseMove
  | MouseOver
  | MouseOut
  | MouseUp
  | MouseDown
  | Click
  | DblClick

mouseEventKey :: MouseEventType -> String
mouseEventKey MouseMove = "mousemove"
mouseEventKey MouseOver = "mouseover"
mouseEventKey MouseOut = "mouseout"
mouseEventKey MouseUp = "mouseup"
mouseEventKey MouseDown = "mousedown"
mouseEventKey Click = "click"
mouseEventKey DblClick = "dblclick"
