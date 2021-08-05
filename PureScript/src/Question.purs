module Question where

import Prelude

import Effect (Effect)
import Effect.Class.Console (log)

class Question a where
  question1 :: a -> Effect Unit
  question2 :: a -> Effect Unit
  question3 :: a -> Effect Unit
  question4 :: a -> Effect Unit

execute :: ∀ a. Question a => a -> Int -> Effect Unit
execute k n = case n of
  1 -> question1 k
  2 -> question1 k
  3 -> question1 k
  4 -> question1 k
  _ -> log ""