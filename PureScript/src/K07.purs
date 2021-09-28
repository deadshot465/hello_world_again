module K07 (K07(..), getNumbers) where
  
import Prelude

import Data.Int (fromString)
import Data.List (List(..), foldr, head, length, (:))
import Data.Maybe (fromMaybe)
import Effect.Aff (Aff, launchAff_)
import Effect.Class (class MonadEffect)
import Effect.Class.Console (log)
import Question (class Question)
import Readline (closeAndExit, getNumber)

data K07 = K07

data AgeTier = Error | Free | Half | TenPercentOff | Normal

showTexts :: ∀ m. Bind m => MonadEffect m => m Unit
showTexts = do
  log "Hello World!"
  log "ようこそ"
  log "PureScriptの世界へ！"

getNumbers :: Int -> Aff (List Int)
getNumbers = go Nil 0
  where
    go acc _ 0 = pure acc
    go acc no count = do
      value <- getNumber (show (no + 1) <> "つ目の値を入力してください。＞") 0 fromString
      go (value : acc) (no + 1) (count - 1)

getAgeTier :: Int -> AgeTier
getAgeTier age | age <= 0 = Error
               | age < 3 || age >= 70 = Free
               | age >= 3 && age <= 15 = Half
               | age >= 60 && age < 70 = TenPercentOff
               | otherwise = Normal

instance Question K07 where
  question1 _ = launchAff_ do
    choice <- getNumber "メッセージを表示しますか？（０：終了する　１：表示する）＞" 0 fromString
    go choice
    closeAndExit
    where
      go 0 = pure unit
      go _ = do
        showTexts
        c <- getNumber "メッセージを表示しますか？（０：終了する　１：表示する）＞" 0 fromString
        go c

  question2 _ = launchAff_ do
    numbers <- getNumbers 3
    let count = length numbers
    let maxValue = foldr max (fromMaybe 0 $ head numbers) numbers
    log $ show count <> "つの中で最大値は" <> show maxValue
    closeAndExit

  question3 _ = launchAff_ do
    age <- getNumber "年齢を入力して下さい。＞" 0 fromString
    log $ case getAgeTier age of
      Error -> "不適切な値が入力されました。"
      Free -> "入場料金無料です。"
      Half -> "子供料金で半額です。"
      TenPercentOff -> "シニア割引で１割引きです。"
      _ -> "通常料金です。"
    closeAndExit

  question4 _ = pure unit