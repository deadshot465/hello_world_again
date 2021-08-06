module K04 (K04(..)) where
  
import Prelude

import Data.Int (fromString)
import Effect.Aff (launchAff_)
import Effect.Class.Console (log)
import Question (class Question)
import Readline (closeAndExit, getNumber)
import Util (randomAff)

data K04 = K04

getAgeMsg :: Int -> String
getAgeMsg age | age < 3 || age >= 70 = "入場料金無料です。"
              | age >= 3 && age <= 15 = "子供料金で半額です。"
              | age >= 60 && age < 70 = "シニア割引で一割引きです。"
              | otherwise = "通常料金です。"

instance Question K04 where
  question1 _ = launchAff_ do
    age <- getNumber "年齢を入力してください。＞" 0 fromString
    log $ if age < 3 || age >= 70 then "入場料金無料です。" else "通常料金です。"
    closeAndExit

  question2 _ = launchAff_ do
    choice <- getNumber "性別を選択してください。（０：男性　１：女性）＞" 2 fromString
    log $ case choice of
      0 -> "あら、格好良いですね。"
      1 -> "あら、モデルさんみたいですね。"
      _ -> "そんな選択肢はありません。"
    closeAndExit

  question3 _ = launchAff_ do
    age <- getNumber "年齢を入力してください。＞" 0 fromString
    log $ getAgeMsg age
    closeAndExit

  question4 _ = launchAff_ do
    log "＊＊＊おみくじプログラム＊＊＊"
    choice <- getNumber "おみくじを引きますか　（はい：１　いいえ：０）＞" 0 fromString
    oracle <- randomAff 0 4
    log $ if choice <= 0 then "" else do
      case oracle of
        0 -> "大吉　とってもいいことがありそう！！"
        1 -> "中吉　きっといいことあるんじゃないかな"
        2 -> "小吉　少しぐらいはいいことあるかもね"
        3 -> "凶　今日はおとなしくておいた方がいいかも"
        4 -> "大凶　これじゃやばくない？早く家に帰った方がいいかも"
        _ -> ""
    closeAndExit