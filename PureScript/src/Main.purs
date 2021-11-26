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
import K07 (K07(..))
import K08 (K08(..))
import K09 (K09(..))
import K09 as K09
import Kex2.Kex2 as Kex2
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

k07 :: K07
k07 = K07

k08 :: K08
k08 = K08

k09 :: K09
k09 = K09

execute :: Int -> Int -> Effect Unit
execute 1 = Question.execute k01
execute 2 = Question.execute k02
execute 3 = Question.execute k03
execute 4 = Question.execute k04
execute 5 = Question.execute k05
execute 6 = Question.execute k06
execute 7 = Question.execute k07
execute 8 = Question.execute k08
execute 9 = Question.execute k09
execute _ = const $ log "Error"

showSelections :: ∀ f. Applicative f => MonadEffect f => Int -> f (Array Unit)
showSelections chapter = traverse (\x -> log $ "\t" <> show x <> ") " <> (if biggerThanTen then "K" else "K0") <> show chapter <> "_" <> show x) numbers
  where
    biggerThanTen = chapter > 10
    numbers | chapter == 9 = [1, 2, 3, 4, 5]
            | otherwise = [1, 2, 3, 4]

assignments :: Array Int
assignments = [1, 2, 3, 4, 5, 6, 7, 8, 9]

showAssignments :: ∀ f. Applicative f => MonadEffect f => f (Array Unit)
showAssignments = traverse (\x -> log (show x <> ") " <> (if biggerThanTen x then "K" else "K0") <> show x <> "\t\t")) assignments
  where
    biggerThanTen = (_ > 10)

main :: Effect Unit
main = launchAff_ do
  _ <- showAssignments
  log "101) Kex2"
  choice <- getNumber "実行したいプログラムを選択してください。" 0 fromString
  case choice of
    101 -> Kex2.run
    _ -> do
      _ <- showSelections choice
      choice2 <- getNumber "" 0 fromString
      if choice == 9 && choice2 == 5 then liftEffect $ K09.question5 k09 else liftEffect $ execute choice choice2