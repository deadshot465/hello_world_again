module Main where

import Prelude

import Data.Int (fromString)
import Data.Traversable (traverse)
import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Class (class MonadEffect, liftEffect)
import Effect.Class.Console (log)
import K01 (K01(..))
import K02 (K02(..))
import K03 (K03(..))
import K04 (K04(..))
import K05 (K05(..))
import K06 (K06(..))
import Question (execute) as Question
import Readline (getNumber)

k01 :: K01
k01 = K01

k02 :: K02
k02 = K02

k03 :: K03
k03 = K03

k04 :: K04
k04 = K04

k05 :: K05
k05 = K05

k06 :: K06
k06 = K06

execute :: Int -> Int -> Effect Unit
execute 1 = Question.execute k01
execute 2 = Question.execute k02
execute 3 = Question.execute k03
execute 4 = Question.execute k04
execute 5 = Question.execute k05
execute 6 = Question.execute k06
execute _ = const $ log "Error"

showSelections :: ∀ f. Applicative f => MonadEffect f => Int -> f (Array Unit)
showSelections chapter = traverse (\x -> log $ "\t" <> show x <> ") " <> (if biggerThanTen then "K" else "K0") <> show chapter <> "_" <> show x) [1, 2, 3, 4]
  where
    biggerThanTen = chapter > 10

assignments :: Array Int
assignments = [1, 2, 3, 4, 5, 6]

showAssignments :: ∀ f. Applicative f => MonadEffect f => f (Array Unit)
showAssignments = traverse (\x -> log (show x <> ") " <> (if biggerThanTen x then "K" else "K0") <> show x <> "\t\t")) assignments
  where
    biggerThanTen = (_ > 10)

main :: Effect Unit
main = launchAff_ do
  _ <- showAssignments
  log ""
  choice <- getNumber "実行したいプログラムを選択してください。" 0 fromString
  _ <- showSelections choice
  choice2 <- getNumber "" 0 fromString
  liftEffect $ execute choice choice2