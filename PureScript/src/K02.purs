module K02 (K02(..)) where
  
import Prelude

import Data.Int (fromString, rem)
import Data.Maybe (fromMaybe)
import Data.Number (fromString) as Number
import Effect.Aff (launchAff_)
import Effect.Class.Console (log)
import Question (class Question)
import Readline (askQuestion, closeAndExit)

data K02 = K02

type Golem = { hp :: Int, defense :: Int, attack :: Int }

seisuu :: Int
seisuu = 3

jissuu :: Number
jissuu = 2.6

moji :: Char
moji = 'A'

instance Question K02 where
  question1 _ = launchAff_ do
    log $ "変数seisuuの値は" <> show seisuu
    log $ "変数jissuuの値は" <> show jissuu
    log $ "変数mojiの値は" <> show moji
    closeAndExit

  question2 _ = launchAff_ do
    s <- askQuestion "一つ目の整数は？"
    let number1 = fromMaybe 0 $ fromString s
    s' <- askQuestion "二つ目の整数は？"
    let number2 = fromMaybe 0 $ fromString s'
    log $ show number1 <> "÷" <> show number2 <> "=" <> show (div number1 number2) <> "..." <> show (rem number1 number2)
    closeAndExit

  question3 _ = launchAff_ do
    s <- askQuestion "一つ目の商品の値段は？"
    let priceA = fromMaybe 0.0 $ Number.fromString s
    a <- askQuestion "個数は？"
    let amountA = fromMaybe 0.0 $ Number.fromString a
    s' <- askQuestion "二つ目の商品の値段は？"
    let priceB = fromMaybe 0.0 $ Number.fromString s'
    a' <- askQuestion "個数は？"
    let amountB = fromMaybe 0.0 $ Number.fromString a'
    let total = (priceA * amountA + priceB * amountB) * 1.1
    log $ "お支払いは税込み￥" <> show total
    closeAndExit

  question4 _ = launchAff_ do
    let golem = { hp: 300, defense: 80, attack: 50 }
    let ({ hp, defense }) = golem
    log $ "ゴーレム　（HP：" <> show hp <> "　防御力：" <> show defense <> "）"
    log $ "HP：" <> show hp
    damage <- askQuestion "今回の攻撃の値を入力してください＞" >>= pure <<< fromMaybe 0 <<< fromString
    let finalDamage = if result > 0 then result else 0 where result = damage - defense
    log $ "ダメージは" <> show finalDamage <> "です。"
    let golem' = golem { hp = hp - finalDamage }
    log $ "残りのHPは" <> show golem'.hp <> "です。"
    closeAndExit