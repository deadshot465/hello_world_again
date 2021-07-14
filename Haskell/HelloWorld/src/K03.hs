module K03 (K03(..)) where

import Prelude
import Question (Question(..))

import Data.Functor ((<&>))
import System.Random (getStdRandom, Random (randomR))

data K03 = K03

getGuessMessage :: (Ord a, Num a) => a -> a -> [Char]
getGuessMessage guess n | guess < 0 || guess > 99 = "反則です！"
                        | guess > n && guess - n <= 10 = "大正解です！"
                        | guess < n && n - guess <= 10 = "惜しい！"
                        | guess == n = "お見事！"
                        | otherwise = if guess > n then "正解です。" else "不正解です。"

instance Question K03 where
  question1 _ = do
    putStrLn "年齢を入力してください。＞"
    age <- getLine 
    let a = (read age :: Int)
    putStrLn $ if a < 20 then "未成年なので購入できません。" else ""
  question2 _ = do
    putStrLn "身長を入力してください。＞"
    height <- getLine >>= \s -> pure (read s :: Double) <&> (* 0.01)
    putStrLn "体重を入力してください。＞"
    weight <- getLine >>= \s -> pure (read s :: Double)
    let standard = height * height * 22.0
    putStrLn $ "あなたの標準体重は" <> show standard <> "です。"
    let diff = weight - standard / standard * 100.0
    putStrLn (if weight > standard && diff > 14.0 then "太り気味です。"
                else if weight < standard && diff < (-14.0) then "痩せ気味です。" else "普通ですね。")
  question3 _ = do
    randomNumber <- (getStdRandom (randomR (0, 99)) :: IO Int)
    putStrLn "０から９９の範囲の数値が決定されました。"
    putStrLn "決められた数値を予想し、この数値よりも大きな値を入力してください＞"
    guess <- getLine >>= \s -> pure (read s :: Int)
    putStrLn $ "決められた数値は" <> show randomNumber <> "です。"
    putStrLn $ if guess > randomNumber then "正解です。" else "不正解です。"
  question4 _ = do
    randomNumber <- (getStdRandom (randomR (0, 99)) :: IO Int)
    putStrLn "０から９９の範囲の数値が決定されました。"
    putStrLn "決められた数値を予想し、この数値よりも大きな値を入力してください＞"
    guess <- getLine >>= \s -> pure (read s :: Int)
    putStrLn $ "決められた数値は" <> show randomNumber <> "です。"
    putStrLn $ getGuessMessage guess randomNumber