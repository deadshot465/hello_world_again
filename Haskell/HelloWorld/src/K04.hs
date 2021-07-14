module K04 (K04(..)) where

import Prelude
import Question (Question(..))
import System.Random (getStdRandom, Random (randomR))

data K04 = K04

getAgeMsg :: (Ord a, Num a) => a -> [Char]
getAgeMsg age | age < 3 || age >= 70 = "入場料金無料です。"
              | age >= 3 && age <= 15 = "子供料金で半額です。"
              | age >= 60 && age < 70 = "シニア割引で一割引きです。"
              | otherwise = "通常料金です。"

instance Question K04 where
  question1 _ = do
    putStrLn "年齢を入力してください。＞"
    age <- getLine >>= \s -> pure (read s :: Int)
    putStrLn $ if age < 3 || age >= 70 then "入場料金無料です。" else "通常料金です。"

  question2 _ = do
    putStrLn "性別を選択してください。（０：男性　１：女性）＞"
    choice <- getLine >>= \s -> pure (read s :: Int)
    putStrLn $ case choice of
      0 -> "あら、格好良いですね。"
      1 -> "あら、モデルさんみたいですね。"
      _ -> "そんな選択肢はありません。"
  
  question3 _ = do
    putStrLn "年齢を入力してください。＞"
    age <- getLine >>= \s -> pure (read s :: Int)
    putStrLn $ getAgeMsg age

  question4 _ = do
    putStrLn "＊＊＊おみくじプログラム＊＊＊"
    putStrLn "おみくじを引きますか　（はい：１　いいえ：０）＞"
    choice <- getLine >>= \s -> pure (read s :: Int)
    oracle <- (getStdRandom (randomR (0, 4)) :: IO Int)
    putStrLn $ if choice <= 0 then "" else do
      case oracle of
        0 -> "大吉　とってもいいことがありそう！！"
        1 -> "中吉　きっといいことあるんじゃないかな"
        2 -> "小吉　少しぐらいはいいことあるかもね"
        3 -> "凶　今日はおとなしくておいた方がいいかも"
        4 -> "大凶　これじゃやばくない？早く家に帰った方がいいかも"
        _ -> ""