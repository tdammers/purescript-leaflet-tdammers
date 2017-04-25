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
import Data.Maybe (Maybe (..))
import Leaflet.LatLng

foreign import data OptVal :: Type
foreign import data Options :: Type

foreign import optValNull :: OptVal
foreign import optValString :: String -> OptVal
foreign import optValNumber :: Number -> OptVal
foreign import optValInt :: Int -> OptVal
foreign import optValBoolean :: Boolean -> OptVal
foreign import optValArray :: Array OptVal -> OptVal
foreign import unsafeOptVal :: ∀ a. a -> OptVal

class IsOptVal a where
  toOptVal :: a -> OptVal

instance isOptValString :: IsOptVal String where
  toOptVal = optValString

instance isOptValNumber :: IsOptVal Number where
  toOptVal = optValNumber

instance isOptValInt :: IsOptVal Int where
  toOptVal = optValInt

instance isOptValBoolean :: IsOptVal Boolean where
  toOptVal = optValBoolean

instance isOptValArray :: IsOptVal a => IsOptVal (Array a) where
  toOptVal = optValArray <<< P.map toOptVal

instance isOptValTuple :: (IsOptVal a, IsOptVal b)
                       => IsOptVal (Tuple a b) where
  toOptVal (Tuple x y) = optValArray [ toOptVal x, toOptVal y ]

instance isOptValMaybe :: IsOptVal a
                       => IsOptVal (Maybe a) where
  toOptVal (Just x) = toOptVal x
  toOptVal Nothing = optValNull

instance isOptValLatLng :: IsOptVal LatLng where
  toOptVal = unsafeOptVal

instance isOptValLatLngBounds :: IsOptVal LatLngBounds where
  toOptVal = unsafeOptVal

mkOption :: ∀ a. IsOptVal a => String -> a -> Tuple String OptVal
mkOption name val = Tuple name (toOptVal val)

foreign import mkOptionsJS :: (∀ a. Tuple String a -> String)
                           -> (∀ b. Tuple b OptVal -> OptVal)
                           -> Array (Tuple String OptVal)
                           -> Options

class IsOption a where
  toOption :: a -> Tuple String OptVal

mkOptions :: ∀ a. IsOption a
          => Array a
          -> Options
mkOptions optlist =
  mkOptionsJS fst snd $ P.map toOption optlist
