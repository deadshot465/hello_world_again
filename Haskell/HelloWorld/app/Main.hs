module Main where

import Prelude

import Data.Foldable (traverse_, toList)
import Data.Sequence (fromList)

import Question (execute, Question(..))
import K01 (K01(..))
import K02 (K02(..))
import K03 (K03(..))
import K04 (K04(..))
import K05 (K05(..))
import K06 (K06(..))
import K07 (K07(..))
import K08 (K08(..))

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

k08 = K08

execute' :: (Eq a, Eq a1, Num a, Num a1) => a -> a1 -> IO ()
execute' 1 = execute k01
execute' 2 = execute k02
execute' 3 = execute k03
execute' 4 = execute k04
execute' 5 = execute k05
execute' 6 = execute k06
execute' 7 = execute k07
execute' 8 = execute k08
execute' _ = \_ -> putStrLn "Error"

showSelections :: (Show a, Ord a, Num a) => a -> IO ()
showSelections chapter = traverse_ (\x -> putStrLn $ "\t" <> show x <> ") " <> (if biggerThanTen then "K" else "K0") <> show chapter <> "_" <> show x) [1, 2, 3, 4]
  where
    biggerThanTen = chapter > 10

showAssignments :: IO ()
showAssignments = traverse_ (\x -> putStrLn (show x <> ") " <> (if biggerThanTen x then "K" else "K0") <> show x <> "\t\t")) [1, 2, 3, 4, 5, 6, 7, 8cd .]
  where
    biggerThanTen = (> 10)

main :: IO ()
main = do
  putStrLn "実行したいプログラムを選択してください。"
  _ <- showAssignments
  putStrLn ""
  choice <- getLine >>= \s -> pure (read s :: Int)
  _ <- showSelections choice
  choice2 <- getLine >>= \s -> pure (read s :: Int)
  execute' choice choice2