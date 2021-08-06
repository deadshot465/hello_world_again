module K06 (K06(..)) where
  
import Prelude

import Data.Foldable (sum)
import Data.Int (fromString, toNumber)
import Data.List (List(..), intercalate, length, mapWithIndex, reverse, (:))
import Data.Tuple (Tuple(..))
import Data.Unfoldable (replicate)
import Effect.Aff (Aff, launchAff_)
import Effect.Class (liftEffect)
import Effect.Class.Console (log)
import Question (class Question)
import Readline (_writeToStdout, closeAndExit, getNumber)

data K06 = K06

getAges :: ∀ a. a -> Aff (List Int)
getAges _ = inputAge 0 5 Nil
  where
    inputAge _ 0 acc = pure acc
    inputAge no amount acc = do
      age <- getNumber (show (no + 1) <> "人目の年齢を入力して下さい：") 0 fromString
      inputAge (no + 1) (amount - 1) (age : acc)

makeUpperPyramid :: Int -> List String
makeUpperPyramid levels = make 0 levels Nil # reverse
  where
    make :: Int -> Int -> List String -> List String
    make _ 0 acc = acc
    make cur l acc = make (cur + 1) (l - 1) (((replicate (cur + 1) "*" :: List String) # intercalate "") : acc)

makeLowerPyramid :: Int -> List String
makeLowerPyramid levels = make levels Nil # reverse
  where
    make :: Int -> List String -> List String
    make 0 acc = acc
    make l acc = make (l - 1) (((replicate l "*" :: List String) # intercalate "") : acc)

makeSpecialPyramid :: Int -> List String
makeSpecialPyramid levels = make levels 0 Nil
  where
    make :: Int -> Int -> List String -> List String
    make 0 _ acc = acc
    make stars spaces acc = make (stars - 1) (spaces + 1) (((replicate spaces " " <> replicate stars "*" :: List String) # intercalate "") : acc)

countTens :: Int -> Int
countTens remains = div remains 10

countFifties :: Int -> Int -> List (Tuple Int Int) -> List (Tuple Int Int)
countFifties amount remains arr | amount < 0 = arr
                                | otherwise = countFifties (amount - 1) remains ((Tuple amount (countTens $ remains - (50 * amount))) : arr)

data Triple a b c = Triple a b c

countHundreds :: Int -> Int -> List (Triple Int Int Int) -> List (Triple Int Int Int)
countHundreds amount remains arr | amount < 0 = arr
                                 | otherwise = do
                                   let remains' = remains - (100 * amount)
                                   let arr' = countFifties (div remains' 50) remains' Nil <#> \(Tuple x y) -> Triple amount x y
                                   countHundreds (amount - 1) remains (arr' <> arr)

countCombinations :: Int -> List (Triple Int Int Int)
countCombinations amount = countHundreds (div amount 100) amount Nil

printOneToTen :: Int -> List Int -> List Int
printOneToTen 0 arr = arr
printOneToTen num arr = printOneToTen (num - 1) (num : arr)

calculate :: Int -> List (List Int) -> List (List Int)
calculate 0 arr = arr
calculate i arr = calculate (i - 1) (multiply 9 Nil : arr)
  where
    multiply 0 arr' = arr'
    multiply j arr' = multiply (j - 1) (i * j : arr')

listWithIndex :: Int -> List Int -> String
listWithIndex i x = show (i + 1) <> "\t|\t" <> ((show <$> x) # intercalate "\t")

instance Question K06 where
  question1 _ = launchAff_ do
    ages <- getAges unit
    let count = length ages
    let totalAges = sum ages
    let count' = toNumber count
    let totalAges' = toNumber totalAges
    log $ show count <> "人の平均年齢は" <> show (totalAges' / count') <> "です。"
    closeAndExit

  question2 _ = launchAff_ do
    let upper = makeUpperPyramid 8 # intercalate "\n"
    log upper
    let lower = makeLowerPyramid 8 # intercalate "\n"
    log lower
    let special = makeSpecialPyramid 8 # intercalate "\n"
    log special
    closeAndExit

  question3 _ = launchAff_ do
    let combinations = countCombinations 370 <#> \(Triple x y z) -> "10円の硬貨" <> show z <> "枚 50円の硬貨" <> show y <> "枚 100円の硬貨" <> show x <> "枚"
    log $ intercalate "\n" combinations
    log $ "\n以上" <> show (length combinations) <> "通りを発見しました。"
    closeAndExit

  question4 _ = launchAff_ do
    _ <- liftEffect $ _writeToStdout "\t|\t"
    let oneToTen = printOneToTen 9 Nil <#> show # intercalate "\t"
    log oneToTen
    log $ (replicate 90 "-" :: List String) # intercalate ""
    let calculations = calculate 9 Nil # mapWithIndex listWithIndex
    log $ intercalate "\n" calculations
    closeAndExit