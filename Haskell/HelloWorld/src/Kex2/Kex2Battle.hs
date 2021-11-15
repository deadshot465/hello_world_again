{-# LANGUAGE NamedFieldPuns #-}
module Kex2.Kex2Battle where

import Prelude
import Control.Monad ((>=>))
import Data.Text (Text, pack, unpack)
import Shared.Player (Player(..))
import Utility (getInt, getRandomInteger)
import Shared.Enemy (makeEnemy, EnemyType(..), Enemy(..))
import Shared.Constants (attackHit, skillHit, magicHit)

data AttackMethod
  = Attack Integer Integer
  | Skill Integer Integer
  | Magic Integer Integer

data ProgressResult
  = End Text
  | Continue Player

gameLoop :: (Show a, Num a) => Player -> a -> Int -> IO Text
gameLoop Player{ playerHp } kills choice | playerHp <= 0 || choice == 0 = pure $ pack $ "リ〇ミト！\n戦闘回数：" <> show kills <> "回　残りHP：" <> show playerHp
gameLoop player@Player{ playerHp } kills _ = do
  putStrLn $ "\n現HP：" <> show playerHp
  putStrLn "奥に進みますか？（１：奥に進む　０．帰る）＞"
  choice <- getInt
  case choice of
    0 -> gameLoop player kills choice
    _ -> do
      ordinal <- getRandomInteger 2
      enemy <- makeEnemy ordinal
      progressResult <- engageBattle (extractEnemyData enemy) player
      case progressResult of
        End txt -> do
          putStrLn $ unpack txt
          gameLoop player{ playerHp = 0 } kills 0
        Continue pl -> gameLoop pl (kills + 1) 1

extractEnemyData :: EnemyType -> Enemy
extractEnemyData enemy = case enemy of
  Golem e -> e
  Goblin e -> e
  Slime e -> e

engageBattle :: Enemy -> Player -> IO ProgressResult
engageBattle enemy@Enemy{ enemyName, enemyLevel } player = do
  putStrLn $ unpack enemyName <> "Lv." <> show (enemyLevel + 1) <> "が現れた！"
  battleLoop enemy player

battleLoop :: Enemy -> Player -> IO ProgressResult
battleLoop Enemy{ enemyName, enemyLevel, enemyHp } player | enemyHp <= 0 = do
  putStrLn $ unpack enemyName <> "Lv." <> show (enemyLevel + 1) <> "を倒した！"
  pure $ Continue player
battleLoop Enemy{ enemyName } Player{ playerHp } | playerHp <= 0 = do
  putStrLn $ "あなたは" <> unpack enemyName <> "に負けました！"
  pure $ End $ pack "ゲームオーバー！"
battleLoop enemy@Enemy{ enemyName, enemyHp } player = do
  putStrLn $ unpack enemyName <> " 残りHP：" <> show enemyHp
  putStrLn "武器を選択してください（１．攻撃　２．特技　３．魔法）＞"
  attackMethod <- getInt >>= \i -> selectAttack i
  newEnemy <- damageEnemy attackMethod enemy
  putStrLn $ unpack enemyName <> "の攻撃！"
  newPlayer@Player{ playerHp = newPlayerHp } <- damagePlayer enemy player
  if newPlayerHp > 0 then do
    putStrLn $ "プレイヤー残りHP：" <> show newPlayerHp
    battleLoop newEnemy newPlayer
  else
    battleLoop newEnemy newPlayer

checkHitOrMiss :: Integer -> IO Bool
checkHitOrMiss hit = getRandomInteger 100 >>= \i -> pure $ i < hit

selectAttack :: (Eq t, Num t) => t -> IO AttackMethod
selectAttack 1 = getRandomInteger 40 >>= \i -> pure $ Attack (60 + i) attackHit
selectAttack 2 = getRandomInteger 100 >>= \i -> pure $ Skill (30 + i) skillHit 
selectAttack 3 = getRandomInteger 180 >>= \i -> pure $ Magic (20 + i) magicHit 
selectAttack _ = selectAttack 1

damageEnemy :: AttackMethod -> Enemy -> IO Enemy
damageEnemy attackMethod enemy@Enemy{ enemyHp, enemyFlee, enemyDefense } = do
  let (dmg, hit) = case attackMethod of
        Attack d h -> (d, h)
        Skill d h -> (d, h)
        Magic d h -> (d, h)
  hitOrMiss <- checkHitOrMiss $ hit - enemyFlee
  if hitOrMiss then do
    let actualDamage = if dmg - enemyDefense < 0 then 0 else dmg - enemyDefense
    putStrLn $ show actualDamage <> "のダメージ！"
    let newEnemyHp = if enemyHp - actualDamage < 0 then 0 else enemyHp - actualDamage
    pure $ enemy{ enemyHp = newEnemyHp }
  else do
    putStrLn "攻撃を外した！"
    pure enemy

damagePlayer :: Enemy -> Player -> IO Player
damagePlayer Enemy{ enemyHit, enemyAttack } player@Player{ playerHp, playerDefense } = do
  hitOrMiss <- checkHitOrMiss enemyHit
  if hitOrMiss then do
    let injury = if enemyAttack - playerDefense < 0 then 0 else enemyAttack - playerDefense
    putStrLn $ show injury <> "のダメージ！"
    let newPlayerHp = if playerHp - injury < 0 then 0 else playerHp - injury
    pure player{ playerHp = newPlayerHp }
  else do
    putStrLn "攻撃を外した！"
    pure player