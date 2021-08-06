module Readline (_writeToStdout, askQuestion, closeAndExit, getNumber) where
  
import Prelude

import Control.Promise (Promise, toAff)
import Data.Maybe (Maybe, fromMaybe)
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Class (liftEffect)

foreign import _askQuestion :: String -> Effect (Promise String)
foreign import _closeAndExit :: Effect Unit
foreign import _writeToStdout :: String -> Effect Boolean

askQuestion :: String -> Aff String
askQuestion question = do
  p <- liftEffect $ _askQuestion question
  toAff p

getNumber :: ∀ a. String -> a -> (String -> Maybe a) -> Aff a
getNumber msg default func = askQuestion msg >>= pure <<< fromMaybe default <<< func

closeAndExit :: Aff Unit
closeAndExit = liftEffect _closeAndExit