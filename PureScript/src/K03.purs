module K03 (K03(..)) where
  
import Prelude

import Data.Int (fromString)
import Data.Number (fromString) as Number
import Effect.Aff (launchAff_)
import Effect.Class.Console (log)
import Question (class Question)
import Readline (closeAndExit, getNumber)
import Util (randomAff)

data K03 = K03

guessMessage :: Int -> Int -> String
guessMessage guess n | guess < 0 || guess > 99 = "反則です！"
                     | guess > n && guess - n <= 10 = "大正解です！"
                     | guess < n && n - guess <= 10 = "惜しい！"
                     | guess == n = "お見事！"
                     | otherwise = if guess > n then "正解です。" else "不正解です。"

instance Question K03 where
  question1 _ = launchAff_ do
    age <- getNumber "年齢を入力してください。＞" 0 fromString
    log $ if age < 20 then "未成年なので購入できません。" else ""
    closeAndExit

  question2 _ = launchAff_ do
    height <- getNumber "身長を入力してください。＞" 0.0 Number.fromString <#> (_ * 0.01)
    weight <- getNumber "体重を入力してください。＞" 0.0 Number.fromString
    let standard = height * height * 22.0
    log $ "あなたの標準体重は" <> show standard <> "です。"
    let diff = weight - standard / standard * 100.0
    log $ if weight > standard && diff > 14.0 then "太り気味です。"
          else if weight < standard && diff < (-14.0) then "痩せ気味です。" else "普通ですね。"
    closeAndExit

  question3 _ = launchAff_ do
    randomNumber <- randomAff 0 99
    log "０から９９の範囲の数値が決定されました。"
    guess <- getNumber "決められた数値を予想し、この数値よりも大きな値を入力してください＞" 0 fromString
    log $ "決められた数値は" <> show randomNumber <> "です。"
    log $ if guess > randomNumber then "正解です。" else "不正解です。"
    closeAndExit

  question4 _ = launchAff_ do
    randomNumber <- randomAff 0 99
    log "０から９９の範囲の数値が決定されました。"
    guess <- getNumber "決められた数値を予想し、この数値よりも大きな値を入力してください＞" 0 fromString
    log $ "決められた数値は" <> show randomNumber <> "です。"
    log $ guessMessage guess randomNumber
    closeAndExit