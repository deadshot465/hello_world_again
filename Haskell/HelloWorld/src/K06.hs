module K06 (K06(..)) where

import Prelude
import Question (Question(..))

import Data.Foldable (toList)
import Data.Function ((&))
import Data.Functor ( (<&>) )
import Data.Sequence (mapWithIndex, fromList)
import Data.Text (pack, unpack, intercalate)

data K06 = K06

getAges :: p -> IO [Int]
getAges _ = inputAge 0 5 []
  where
    inputAge _ 0 acc = pure acc
    inputAge no amount acc = do
      putStrLn $ show (no + 1) <> "人目の年齢を入力して下さい："
      age <- getLine >>= \s -> pure (read s :: Int)
      inputAge (no + 1) (amount - 1) (age : acc)

makeUpperPyramid :: (Eq t, Num t) => t -> [[Char]]
makeUpperPyramid levels = make 0 levels [] & reverse
  where
    make _ 0 acc = acc
    make cur l acc = make (cur + 1) (l - 1) ((replicate (cur + 1) "*" & concat) : acc)

makeLowerPyramid :: Int -> [[Char]]
makeLowerPyramid levels = make levels [] & reverse
  where
    make 0 acc = acc
    make l acc = make (l - 1) ((replicate l "*" & concat) : acc)

makeSpecialPyramid :: Int -> [[Char]]
makeSpecialPyramid levels = make levels 0 []
  where
    make 0 _ acc = acc
    make stars spaces acc = make (stars - 1) (spaces + 1) (((replicate spaces " " <> replicate stars "*") & concat) : acc)

countTens :: Integral a => a -> a
countTens remains = div remains 10

countFifties :: Integral b => b -> b -> [(b, b)] -> [(b, b)]
countFifties amount remains arr | amount < 0 = arr
                                | otherwise = countFifties (amount - 1) remains ((amount, countTens $ remains - (50 * amount)) : arr)

countHundreds :: Integral t => t -> t -> [(t, t, t)] -> [(t, t, t)]
countHundreds amount remains arr | amount < 0 = arr
                                 | otherwise = do
                                   let remains' = remains - (100 * amount)
                                   let arr' = countFifties (div remains' 50) remains' [] <&> (\(x, y) -> (amount, x, y))
                                   countHundreds (amount - 1) remains (arr' <> arr)

countCombinations :: Integral t => t -> [(t, t, t)]
countCombinations amount = countHundreds (div amount 100) amount []

printOneToTen :: (Eq a, Num a) => a -> [a] -> [a]
printOneToTen 0 arr = arr
printOneToTen num arr = printOneToTen (num - 1) (num : arr)

calculate :: (Eq t, Num t) => t -> [[t]] -> [[t]]
calculate 0 arr = arr
calculate i arr = calculate (i - 1) (multiply 9 [] : arr)
  where
    multiply 0 arr' = arr'
    multiply j arr' = multiply (j - 1) (i * j : arr')

listWithIndex :: (Num a1, Show a1, Show a2) => a1 -> [a2] -> String
listWithIndex i x = show (i + 1) <> "\t|\t" <> ((pack <$> (show <$> x)) & intercalate (pack "\t") & unpack)

instance Question K06 where
  question1 _ = do
    ages <- getAges ()
    let count = length ages
    let totalAges = sum ages
    let count' = (fromInteger $ toInteger count :: Float)
    let totalAges' = (fromInteger $ toInteger totalAges :: Float)
    putStrLn $ show count <> "人の平均年齢は" <> show (totalAges' / count') <> "です。"

  question2 _ = do
    let upper = makeUpperPyramid 8 & unlines
    putStrLn upper
    putStrLn ""
    let lower = makeLowerPyramid 8 & unlines
    putStrLn lower
    putStrLn ""
    let special = makeSpecialPyramid 8 & unlines
    putStrLn special

  question3 _ = do
    let combinations = countCombinations 370 <&> (\(x, y, z) -> "10円の硬貨" <> show z <> "枚 50円の硬貨" <> show y <> "枚 100円の硬貨" <> show x <> "枚")
    putStrLn $ unlines combinations
    putStrLn ""
    putStrLn $ "以上" <> show (length combinations) <> "通りを発見しました。"

  question4 _ = do
    putStr "\t|\t"
    let oneToTen = printOneToTen 9 [] <&> show <&> pack & intercalate (pack "\t") & unpack
    putStrLn oneToTen
    putStrLn $ replicate 90 "-" & concat
    let calculations = calculate 9 [] & fromList & mapWithIndex listWithIndex
    putStrLn (toList calculations & unlines) 