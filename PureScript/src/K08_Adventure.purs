module K08Adventure where

import Prelude

import Data.Int (fromString)
import Effect.Aff (Aff)
import Effect.Class.Console (log)
import Readline (getNumber)
import Util (randomAff)
  
type Golem =
  { hp :: Int
  , defense :: Int
  , attack :: Int
  }

data AttackMethod
  = Attack Int
  | Skill Int
  | Magic Int

data ProgressResult = Continue Int | End String

selectAttack :: Int -> Aff AttackMethod
selectAttack 1 = randomAff 0 35 >>= \n -> pure $ Attack $ n + 65
selectAttack 2 = randomAff 0 100 >>= \n -> pure $ Attack $ n + 50
selectAttack 3 = randomAff 0 167 >>= \n -> pure $ Attack $ n + 33
selectAttack _ = selectAttack 1

damagePlayer :: Int -> Int -> Aff Int
damagePlayer golemAttack playerHp = do
  log "ゴーレム：「ハハハハハ、情けないな！貴様は弱すぎる！」"
  log $ "ゴーレムがあなたを攻撃しました！攻撃値：" <> show golemAttack
  pure $ playerHp - golemAttack

battleLoop :: Int -> Golem -> Int -> Aff ProgressResult
battleLoop golemLevel { hp: 0 } playerHp = do
  log $ "ゴーレムLv." <> show golemLevel <> "を倒した！"
  pure $ Continue playerHp
battleLoop golemLevel golem@{ hp, defense, attack } playerHp = do
  log $ "ゴーレムLv." <> show golemLevel <> "残りHP：" <> show hp
  choice <- getNumber "武器を選択してください（１．攻撃　２．特技　３．魔法）＞" 0 fromString
  
  attackMethod <- selectAttack choice
  let baseDamage = case attackMethod of
        Attack dmg -> dmg
        Skill dmg -> dmg
        Magic dmg -> dmg
      actualDamage = if baseDamage - defense <= 0 then 0 else baseDamage - defense
  
  log $ "ダメージは" <> show actualDamage <> "です。"
  
  if actualDamage <= 0 then do
    newPlayerHp <- damagePlayer attack playerHp
    if newPlayerHp <= 0 then
      pure $ End "あなたはゴーレムに負けました！"
    else do
      log $ "あなたの残りHPは：" <> show newPlayerHp
      battleLoop golemLevel golem newPlayerHp
  else do
    let newGolemHp = if hp - actualDamage <= 0 then 0 else hp - actualDamage
    battleLoop golemLevel golem{ hp = newGolemHp } playerHp

engageBattle :: Int -> Aff ProgressResult
engageBattle playerHp = do
  golemLevel <- randomAff 0 9
  let golem = { hp: golemLevel * 50 + 100, defense: golemLevel * 10 + 40, attack: golemLevel * 10 + 30 }
  log $ "ゴーレムLv." <> show golemLevel <> "が現れた！"
  battleLoop golemLevel golem playerHp

gameLoop :: Int -> Aff String
gameLoop 0 = pure "ゲームオーバー！"
gameLoop playerHp = do
  log $ "あなたのHP：" <> show playerHp
  choice <- getNumber "奥に進みますか？（１：奥に進む　０．帰る）＞" 0 fromString
  case choice of
    0 -> pure "リレ〇ト！"
    _ -> engageBattle playerHp >>= \result -> case result of
                                      End msg -> pure msg
                                      Continue hp' -> gameLoop hp'