module K09 where

import Prelude

import Data.Function ((&))
import qualified K06
import Question (Question(..))
import qualified Data.Sequence
import Utility (getInt)
import Data.Sequence (traverseWithIndex)
import Data.Foldable (traverse_, Foldable (toList))
import Control.Monad (void)
import Data.List (insert, sort)

data K09 = K09

transform :: (Foldable t, Num a) => t [a] -> [a] -> [a]
transform xs acc
  = foldl
      (\acc' student
         -> Data.Foldable.toList (Data.Sequence.mapWithIndex (\i score -> score + (student !! i)) (Data.Sequence.fromList acc'))) acc xs

inputNumbers :: (Eq t, Num t, Show t) => t -> Int -> [Int] -> IO [Int]
inputNumbers n choice acc | choice < 0 || n == 100 = pure acc
                          | otherwise = do
                            putStrLn $ show n <> "件目の入力："
                            number <- getInt
                            inputNumbers (n + 1) number (number : acc)

instance Question K09 where
  question1 _ = do
    ages <- K06.getAges 3
    putStrLn $ replicate 90 "-" & concat
    let count = length ages & toInteger & fromInteger :: Float
    let total = sum ages & toInteger & fromInteger :: Float
    traverseWithIndex (\i n -> putStrLn $ show (i + 1) <> "人目：" <> show n <> "歳") (Data.Sequence.fromList ages)
    putStrLn $ "平均年齢：" <> show (total / count) <> "歳"

  question2 _ = do
    let numbers = [8, 3, 12, 7, 9]
    putStr "元々の配列："
    traverse_ (\x -> putStr $ show x <> " ") numbers
    putStrLn "\n逆順での表示："
    traverse_ (\x -> putStr $ show x <> " ") $ reverse numbers

  question3 _ = do
    putStrLn ""
    let studentScores = [[52, 71, 61, 47], [6, 84, 81, 20], [73, 98, 94, 95]]
    putStrLn "\t|\t科目A\t科目B\t科目C\t科目D"
    putStrLn $ replicate 65 "-" & concat
    void $ traverseWithIndex (\i student -> do
      putStr $ "学生" <> show (i + 1) <> "\t|\t"
      traverse_ (\score -> putStr $ show score <> "\t") student
      putStrLn "") (Data.Sequence.fromList studentScores)

  question4 _ = do
    putStrLn ""
    let studentScores = [[52, 71, 61, 47], [6, 84, 81, 20], [73, 98, 94, 95]]
    let withSum = (\student -> student ++ [sum student]) <$> studentScores
    putStrLn "\t|\t科目A\t科目B\t科目C\t科目D\t|\t合計点"
    putStrLn $ replicate 65 "-" & concat
    traverseWithIndex (\i student -> do
      putStr $ "学生" <> show (i + 1) <> "\t|\t"
      traverse_ (\score -> if score == last student then putStr $ "|\t" <> show score <> "\t" else putStr $ show score <> "\t") student
      putStrLn "") (Data.Sequence.fromList withSum)
    let average = fromInteger . toInteger <$> transform withSum [0, 0, 0, 0, 0] :: [Float]
    putStr "平均点\t|\t"
    traverse_ (\score -> if score == last average then putStr $ "|\t" <> show (score / 3.0) <> "\t" else putStr $ show (score / 3.0) <> "\t") average

question5 :: K09 -> IO ()
question5 _ = do
  input <- inputNumbers 1 0 []
  putStrLn "----並び替え後----"
  print (sort input)