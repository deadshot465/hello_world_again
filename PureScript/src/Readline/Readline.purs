module Readline (askQuestion, closeAndExit) where
  
import Prelude

import Control.Promise (Promise, toAff)
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Class (liftEffect)

foreign import _askQuestion :: String -> Effect (Promise String)
foreign import _closeAndExit :: Effect Unit

askQuestion :: String -> Aff String
askQuestion question = do
  p <- liftEffect $ _askQuestion question
  toAff p

closeAndExit :: Aff Unit
closeAndExit = liftEffect _closeAndExit