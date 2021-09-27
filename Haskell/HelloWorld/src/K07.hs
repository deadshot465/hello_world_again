module K07 where

import Prelude
import Question (Question(..))
import Utility (getInt)

data K07 = K07

data AgeTier = Error | Free | Half | TenPercentOff | Normal

showTexts :: IO ()
showTexts = do
  putStrLn "Hello World!"
  putStrLn "ようこそ"
  putStrLn "Haskellの世界へ！"

getNumbers :: Integer -> IO [Int]
getNumbers = go [] 0
  where
    go acc _ 0 = pure acc
    go acc no count' = do
      putStrLn $ show (no + 1) <> "つ目の値を入力してください。＞"
      value <- getInt 
      go (value : acc) (no + 1) (count' - 1)

getAgeTier :: (Ord a, Num a) => a -> AgeTier
getAgeTier age | age <= 0 = Error
               | age < 3 || age >= 70 = Free
               | age >= 3 && age <= 15 = Half
               | age >= 60 && age < 70 = TenPercentOff
               | otherwise = Normal

instance Question K07 where
  question1 _ = do
    putStrLn "メッセージを表示しますか？（０：終了する　１：表示する）＞"
    choice <- getInt
    go choice
    where
      go 0 = pure ()
      go choice' = do
        showTexts
        putStrLn "メッセージを表示しますか？（０：終了する　１：表示する）＞"
        c <- getInt 
        go c
  
  question2 _ = do
    numbers <- getNumbers 3
    let count = length numbers
    let maxValue = foldr max (head numbers) numbers
    putStrLn $ show count <> "つの中で最大値は" <> show maxValue
  
  question3 _ = do
    putStrLn "年齢を入力して下さい。＞"
    age <- getInt 
    putStrLn $ case getAgeTier age of
      Error -> "不適切な値が入力されました。"
      Free -> "入場料金無料です。"
      Half -> "子供料金で半額です。"
      TenPercentOff -> "シニア割引で１割引きです。"
      _ -> "通常料金です。"

  question4 _ = pure ()