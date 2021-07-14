{-# LANGUAGE NamedFieldPuns #-}
module K05 (K05(..)) where

import Prelude
import Question (Question(..))

import System.Random (getStdRandom, Random (randomR))

data K05 = K05

question1Loop :: (Ord a1, Fractional a1, Num a2, Show a2, Show a1) => a1 -> a2 -> String
question1Loop salary age | salary < 50.0 = question1Loop (salary * 1.035) (age + 1)
                         | otherwise = show age <> "歳で月給" <> show salary <> "万円"

question2Loop :: Int -> IO ()
question2Loop choice | choice == 1 = putStrLn "よし、学校へ行こう！"
                     | otherwise = do
                       putStrLn "起きろ～"
                       putStrLn "1．起きた　2．あと5分…　3．Zzzz…\t入力："
                       choice <- getLine >>= \s -> pure (read s :: Int)
                       question2Loop choice

question3Loop :: Int -> IO b
question3Loop choice | choice == 1 = do
                       putStrLn "よし、学校へ行こう！"
                       question3Loop 0
                     | otherwise = do
                       putStrLn "起きろ～"
                       putStrLn "1．起きた　2．あと5分…　3．Zzzz…\t入力："
                       choice <- getLine >>= \s -> pure (read s :: Int)
                       question3Loop choice

data Golem = Golem { hp :: Int, defense :: Int, attack :: Int }

getGolemData :: Golem -> (Int, Int, Int)
getGolemData Golem { hp, defense, attack } = (hp, defense, attack)

inputDamage :: Int -> IO Int
inputDamage choice = case choice of
  1 -> (getStdRandom (randomR (0, 40)) :: IO Int) >>= \n -> pure $ 60 + n
  2 -> (getStdRandom (randomR (0, 100)) :: IO Int) >>= \n -> pure $ 30 + n
  3 -> (getStdRandom (randomR (0, 180)) :: IO Int) >>= \n -> pure $ 20 + n
  _ -> do
    putStrLn "攻撃手段を選択してください（1．攻撃　2．特技　3．魔法）＞"
    n <- getLine >>= \s -> pure (read s :: Int)
    inputDamage n

question4Loop :: Golem -> Int -> IO ()
question4Loop Golem { hp, defense, attack } playerHp | hp == 0 && playerHp /= 0 = putStrLn "ゴーレムを倒しました！"
                                                     | hp /= 0 && playerHp == 0 = putStrLn "あなたはゴーレムに負けました！ゲームオーバー！"
                                                     | otherwise = do
                                                       putStrLn $ "ゴーレム残りHP：" <> show hp
                                                       damage <- inputDamage 0
                                                       putStrLn $ "基礎攻撃力は" <> show damage <> "です。"
                                                       let actualDamage = if diff <= 0 then 0 else diff where diff = damage - defense
                                                       case actualDamage of
                                                         0 -> do
                                                           putStrLn "ゴーレム：「ハハハハハ、情けないな！貴様は弱すぎる！」"
                                                           putStrLn $ "ゴーレムがあなたを攻撃しました！攻撃値：" <> show attack
                                                           let playerHp' = if diff' < 0 then 0 else diff' where diff' = playerHp - attack
                                                           putStrLn $ "あなたの残りHPは：" <> show playerHp'
                                                           question4Loop Golem { hp = hp, defense = defense, attack = attack } playerHp'
                                                         _ -> do
                                                           putStrLn $ "ダメージは" <> show actualDamage <> "です。"
                                                           let golemHp' = if diff' < 0 then 0 else diff' where diff' = hp - actualDamage
                                                           putStrLn $ "残りのHPは" <> show golemHp' <> "です。"
                                                           question4Loop Golem { hp = golemHp', defense = defense, attack = attack } playerHp

instance Question K05 where
  question1 _ = do
    let salary = 19.0
    let age = 22
    putStrLn $ question1Loop salary age

  question2 _ = do
    question2Loop 0

  question3 _ = do
    question3Loop 0

  question4 _ = do
    golemHp <- (getStdRandom (randomR (0, 200)) :: IO Int) >>= \n -> pure (n + 300)
    let golem = Golem { hp = golemHp, defense = 80, attack = 50 }
    playerHp <- (getStdRandom (randomR (0, 100)) :: IO Int) >>= \n -> pure (n + 200)
    let (hp, defense, attack) = getGolemData golem
    putStrLn $ "ゴーレム　（HP：" <> show hp <> "　防御力：" <> show defense <> "）"
    question4Loop golem playerHp