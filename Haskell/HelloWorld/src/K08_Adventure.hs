{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE LambdaCase #-}
module K08_Adventure where

import Prelude
import Utility (getRandomInt, getInt)

data Golem = Golem
  { hp :: Int
  , defense :: Int
  , attack :: Int
  }

data AttackMethod
  = Attack Int
  | Skill Int
  | Magic Int

data ProgressResult
  = End String
  | Continue Int

selectAttack :: (Eq t, Num t) => t -> IO AttackMethod
selectAttack 1 = getRandomInt 35 >>= \n -> pure $ Attack $ n + 65
selectAttack 2 = getRandomInt 100 >>= \n -> pure $ Skill $ n + 50
selectAttack 3 = getRandomInt 167 >>= \n -> pure $ Magic $ n + 33
selectAttack _ = selectAttack 1

damagePlayer :: (Show b, Num b) => b -> b -> IO b
damagePlayer golemAttack playerHp = do
  putStrLn "ゴーレム：「ハハハハハ、情けないな！貴様は弱すぎる！」"
  putStrLn $ "ゴーレムがあなたを攻撃しました！攻撃値：" <> show golemAttack
  let newPlayerHp = playerHp - golemAttack
  pure newPlayerHp

battleLoop :: Show t => t -> Golem -> Int -> IO ProgressResult
battleLoop golemLevel Golem{ hp = 0 } playerHp = do
  putStrLn $ "ゴーレムLv." <> show golemLevel <> "を倒した！"
  pure $ Continue playerHp
battleLoop golemLevel golem@Golem{ hp, defense, attack } playerHp = do
  putStrLn $ "ゴーレムLv." <> show golemLevel <> "残りHP：" <> show hp
  putStrLn "武器を選択してください（１．攻撃　２．特技　３．魔法）＞"
  
  attackMethod <- getInt >>= \n -> selectAttack n
  let baseDamage = (case attackMethod of
        Attack dmg -> dmg
        Skill dmg -> dmg
        Magic dmg -> dmg)
      actualDamage = if baseDamage - defense <= 0 then 0 else baseDamage - defense
  
  putStrLn $ "ダメージは" <> show actualDamage <> "です。"

  if actualDamage <= 0 then do
    newPlayerHp <- damagePlayer attack playerHp
    if newPlayerHp <= 0 then
      pure $ End "あなたはゴーレムに負けました！"
    else do
      putStrLn $ "あなたの残りHPは：" <> show newPlayerHp
      battleLoop golemLevel golem newPlayerHp
  else do
    let newGolemHp = if hp - actualDamage <= 0 then 0 else hp - actualDamage
    battleLoop golemLevel golem{hp = newGolemHp} playerHp

engageBattle :: Int -> IO ProgressResult
engageBattle playerHp = do
  golemLevel <- getRandomInt 10
  let golem = Golem { hp = golemLevel * 50 + 100, attack = golemLevel * 10 + 40, defense = golemLevel * 10 + 30 }
  putStrLn $ "ゴーレムLv." <> show golemLevel <> "が現れた！"
  battleLoop golemLevel golem playerHp

gameLoop :: Int -> IO String
gameLoop 0 = pure "ゲームオーバー！"
gameLoop playerHp = do
  putStrLn $ "あなたのHP：" <> show playerHp
  putStrLn "奥に進みますか？（１：奥に進む　０．帰る）＞"
  choice <- getInt
  case choice of
    0 -> pure "リレ〇ト！"
    _ -> engageBattle playerHp >>= \case
                                    End msg -> pure msg
                                    Continue hp -> gameLoop hp