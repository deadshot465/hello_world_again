module K09 where

import Prelude

import Data.Array (last, mapWithIndex, replicate, reverse, sort, (!!), (:))
import Data.Foldable (class Foldable, foldl, intercalate, length, sum)
import Data.FoldableWithIndex (traverseWithIndex_)
import Data.Int (fromString, toNumber)
import Data.Maybe (fromMaybe)
import Effect (Effect)
import Effect.Aff (Aff, launchAff_)
import Effect.Class.Console (log)
import K06 (getAges)
import Question (class Question)
import Readline (closeAndExit, getNumber)
  
data K09 = K09

transform :: ∀ f. Foldable f => f (Array Int) -> Array Int -> Array Int
transform xs acc =
  foldl (\acc' student -> mapWithIndex (\i score -> score + (fromMaybe 0 $ student !! i)) acc') acc xs

inputNumbers :: Int -> Int -> Array Int -> Aff (Array Int)
inputNumbers n choice acc | choice < 0 || n == 100 = pure acc
                          | otherwise = do
                            number <- getNumber (show n <> "件目の入力：") 0 fromString
                            inputNumbers (n + 1) number (number : acc)

instance Question K09 where
  question1 _ = launchAff_ do
    ages <- getAges 3
    log $ replicate 90 "-" # intercalate ""
    let count = (length ages :: Int) # toNumber
    let total = sum ages # toNumber
    traverseWithIndex_ (\i n -> log $ show (i + 1) <> "人目：" <> show n <> "歳") ages
    log $ "平均年齢：" <> show (total / count) <> "歳"
    closeAndExit

  question2 _ = launchAff_ do
    let numbers = [8, 3, 12, 7, 9]
    log $ "元々の配列：" <> show numbers
    log $ "逆順での表示：" <> show (reverse numbers)
    closeAndExit

  question3 _ = launchAff_ do
    log ""
    let studentScores = [[52, 71, 61, 47], [6, 84, 81, 20], [73, 98, 94, 95]]
    log "\t|\t科目A\t科目B\t科目C\t科目D"
    log $ replicate 65 "-" # intercalate ""
    traverseWithIndex_ (\i student -> do
      let prefix = "学生" <> show (i + 1) <> "\t|\t"
      let allScores = foldl (\acc score -> acc <> show score <> "\t") "" student
      log $ prefix <> allScores) studentScores
    closeAndExit

  question4 _ = launchAff_ do
    log ""
    let studentScores = [[52, 71, 61, 47], [6, 84, 81, 20], [73, 98, 94, 95]]
    let withSum = (\student -> student <> [sum student]) <$> studentScores
    log "\t|\t科目A\t科目B\t科目C\t科目D\t|\t合計点"
    log $ replicate 65 "-" # intercalate ""
    traverseWithIndex_ (\i student -> do
      let prefix = "学生" <> show (i + 1) <> "\t|\t"
      let lastScore = fromMaybe 0 $ last student
      let allScores = foldl (\acc score -> if score == lastScore then acc <> "|\t" <> show score <> "\t"
                                           else acc <> show score <> "\t") "" student
      log $ prefix <> allScores) withSum
    let average = toNumber <$> transform withSum [0, 0, 0, 0, 0]
    let prefix = "平均点\t|\t"
    let allScores = foldl (\acc score -> if score == (fromMaybe 0.0 $ last average) then acc <> "|\t" <> show (score / 3.0) <> "\t"
                                         else acc <> show (score / 3.0) <> "\t") "" average
    log $ prefix <> allScores
    closeAndExit

question5 :: K09 -> Effect Unit
question5 _ = launchAff_ do
  input <- inputNumbers 1 0 []
  log "----並び替え後----"
  log $ show (sort input)
  closeAndExit