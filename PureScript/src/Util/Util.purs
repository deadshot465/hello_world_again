module Util
  ( randomAff
  )
  where

import Prelude

import Effect.Aff (Aff)
import Effect.Class (liftEffect)
import Effect.Random (randomInt)

randomAff :: Int -> Int -> Aff Int 
randomAff low = liftEffect <<< randomInt low