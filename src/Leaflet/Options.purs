module Leaflet.Options
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
import Data.Array as Array
import Data.Tuple (Tuple (..), fst, snd)

foreign import data OptVal :: Type
foreign import data Options :: Type

foreign import optValStr :: String -> OptVal
foreign import optValNumber :: Number -> OptVal
foreign import optValInt :: Int -> OptVal
foreign import optValBoolean :: Boolean -> OptVal

foreign import mkOptionsJS :: (forall a. Tuple String a -> String)
                           -> (forall b. Tuple b OptVal -> OptVal)
                           -> Array (Tuple String OptVal)
                           -> Options

class IsOption a where
  mkOption :: a -> Tuple String OptVal

mkOptions :: forall a. IsOption a
          => Array a
          -> Options
mkOptions optlist =
  mkOptionsJS fst snd $ P.map mkOption optlist
