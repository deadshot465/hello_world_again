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
import qualified K09 (K09(..), question5)
import qualified Kex2.Kex2 (run)
import qualified Musicians.BandSupervisor (startBand)

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

k09 = K09.K09

execute' :: (Eq a, Eq a1, Num a, Num a1) => a -> a1 -> IO ()
execute' 1 = execute k01
execute' 2 = execute k02
execute' 3 = execute k03
execute' 4 = execute k04
execute' 5 = execute k05
execute' 6 = execute k06
execute' 7 = execute k07
execute' 8 = execute k08
execute' 9 = execute k09
execute' _ = \_ -> putStrLn "Error"

showSelections :: (Show a, Ord a, Num a) => a -> IO ()
showSelections chapter = traverse_ (\x -> putStrLn $ "\t" <> show x <> ") " <> (if biggerThanTen then "K" else "K0") <> show chapter <> "_" <> show x) numbers
  where
    biggerThanTen = chapter > 10
    numbers | chapter == 9 = [1, 2, 3, 4, 5]
            | otherwise = [1, 2, 3, 4]

showAssignments :: IO ()
showAssignments = traverse_ (\x -> putStrLn (show x <> ") " <> (if biggerThanTen x then "K" else "K0") <> show x <> "\t\t")) [1, 2, 3, 4, 5, 6, 7, 8, 9]
  where
    biggerThanTen = (> 10)

main :: IO ()
main = do
  putStrLn "実行したいプログラムを選択してください。"
  _ <- showAssignments
  putStrLn "101) Kex_2"
  putStrLn "103) Band Supervisor"
  choice <- getLine >>= \s -> pure (read s :: Int)
  case choice of
    101 -> Kex2.Kex2.run
    103 -> Musicians.BandSupervisor.startBand 5
    _ -> do
      _ <- showSelections choice
      choice2 <- getLine >>= \s -> pure (read s :: Int)
      if choice == 9 && choice2 == 5 then K09.question5 k09 else execute' choice choice2