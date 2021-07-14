{-# LANGUAGE NamedFieldPuns #-}
module K02 (K02(..)) where

import Prelude
import Question (Question(..))

import Data.Function ((&))

data K02 = K02

seisuu :: Integer
seisuu = 3

jissuu :: Double
jissuu = 2.6

moji :: [Char]
moji = "A"

data Golem = Golem { hp :: Int, defense :: Int, attack :: Int }

getGolemData :: Golem -> (Int, Int, Int)
getGolemData Golem { hp, defense, attack } = (hp, defense, attack)

instance Question K02 where
  question1 _ = do
    putStrLn $ "変数seisuuの値は" <> show seisuu
    putStrLn $ "変数jissuuの値は" <> show jissuu
    putStrLn $ "変数mojiの値は" <> moji
  question2 _ = do
    putStrLn "一つ目の整数は？"
    number1 <- getLine >>= \s -> pure (read s :: Int)
    putStrLn "二つ目の整数は？"
    number2 <- getLine >>= \s -> pure (read s :: Int)
    putStrLn $ show number1 <> "÷" <> show number2 <> "=" <> show (div number1 number2) <> "..." <> show (rem number1 number2)
  question3 _ = do
    putStrLn "一つ目の商品の値段は？"
    priceA <- getLine >>= \s -> pure (read s :: Double)
    putStrLn "個数は？"
    amountA <- getLine >>= \s -> pure (read s :: Double)
    putStrLn "二つ目の商品の値段は？"
    priceB <- getLine >>= \s -> pure (read s :: Double)
    putStrLn "個数は？"
    amountB <- getLine >>= \s -> pure (read s :: Double)
    let total = (priceA * amountA + priceB * amountB) * 1.1
    putStrLn $ "お支払いは税込み￥" <> show total
  question4 _ = do
    let golem = Golem { hp = 300, defense = 80, attack = 50 }
    let (hp, defense, attack) = getGolemData golem
    putStrLn $ "ゴーレム　（HP：" <> show hp <> "　防御力：" <> show defense <> "）"
    putStrLn $ "HP：" <> show hp
    putStrLn "今回の攻撃の値を入力してください＞"
    damage <- getLine >>= \s -> pure (read s :: Int)
    let finalDamage = if result > 0 then result else 0 where result = damage - defense
    putStrLn $ "ダメージは" <> show finalDamage <> "です。"
    let golem = Golem { hp = hp - finalDamage, defense = defense, attack = attack }
    let (hp', _, _) = getGolemData golem
    putStrLn $ "残りのHPは" <> show hp' <> "です。"