module Main where

import Prelude

import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Class.Console (log)
import Readline (askQuestion, closeAndExit)

main :: Effect Unit
main = launchAff_ do
  s <- askQuestion "What's your name?"
  log $ "Hi, " <> s
  closeAndExit
