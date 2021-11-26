module Kex2.Kex2Battle
  ( gameLoop
  )
  where
  
import Prelude

import Data.Int (fromString)
import Data.Tuple (Tuple(..))
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Class (liftEffect)
import Effect.Class.Console (log)
import Effect.Random (randomInt)
import Readline (getNumber)
import Shared.Constants (attackHit, magicHit, skillHit)
import Shared.Enemy (EnemyType(..), Enemy, makeEnemy)
import Shared.Player (Player)
import Util (randomAff)

data AttackMethod
  = Attack Int Int
  | Skill Int Int
  | Magic Int Int

data ProgressResult = End String | Continue Player

gameLoop :: Player -> Int -> Int -> Aff String
gameLoop { playerHp } kills choice | playerHp <= 0 || choice == 0 = pure $ "リ〇ミト！\n戦闘回数：" <> show kills <> "回　残りHP：" <> show playerHp
gameLoop player@{ playerHp } kills _ = do
  log $ "\n現HP：" <> show playerHp
  choice <- getNumber "奥に進みますか？（１：奥に進む　０．帰る）＞" 0 fromString
  case choice of
    0 -> gameLoop player kills choice
    _ -> do
      ordinal <- randomAff 0 2
      enemy <- liftEffect $ makeEnemy ordinal
      progressResult <- engageBattle (extractEnemyData enemy) player
      case progressResult of
        End text -> do
          log text
          gameLoop player{ playerHp = 0 } kills 0
        Continue pl -> gameLoop pl (kills + 1) 1

extractEnemyData :: EnemyType -> Enemy
extractEnemyData enemy = case enemy of
  Golem e -> e
  Goblin e -> e
  Slime e -> e

engageBattle :: Enemy -> Player -> Aff ProgressResult
engageBattle enemy@{ enemyName, enemyLevel } player = do
  log $ enemyName <> "Lv." <> show enemyLevel <> "が現れた！"
  battleLoop enemy player

battleLoop :: Enemy -> Player -> Aff ProgressResult
battleLoop { enemyName, enemyLevel, enemyHp } player | enemyHp <= 0 = do
  log $ enemyName <> "Lv." <> show enemyLevel <> "を倒した！"
  pure $ Continue player
battleLoop { enemyName } { playerHp } | playerHp <= 0 = do
  log $ "あなたは" <> enemyName <> "に負けました！"
  pure $ End "ゲームオーバー！"
battleLoop enemy@{ enemyName, enemyHp } player = do
  log $ enemyName <> " 残りHP：" <> show enemyHp
  attackMethod <- getNumber "武器を選択してください（１．攻撃　２．特技　３．魔法）＞" 0 fromString >>= \i -> liftEffect $ selectAttack i
  newEnemy <- liftEffect $ damageEnemy attackMethod enemy
  log $ enemyName <> "の攻撃！"
  newPlayer@{ playerHp: newPlayerHp } <- liftEffect $ damagePlayer enemy player
  if newPlayerHp > 0 then do
    log $ "プレイヤー残りHP：" <> show newPlayerHp
    battleLoop newEnemy newPlayer
  else
    battleLoop newEnemy newPlayer

selectAttack ∷ Int → Effect AttackMethod
selectAttack 1 = randomInt 1 40 >>= \i -> pure $ Attack (i + 60) attackHit
selectAttack 2 = randomInt 1 100 >>= \i -> pure $ Skill (i + 30) skillHit
selectAttack 3 = randomInt 1 180 >>= \i -> pure $ Magic (i + 20) magicHit
selectAttack _ = selectAttack 1

damageEnemy :: AttackMethod -> Enemy -> Effect Enemy
damageEnemy attackMethod enemy@{ enemyHp, enemyFlee, enemyDefense } = do
  let (Tuple dmg hit) = case attackMethod of
        Attack d h -> Tuple d h
        Skill d h -> Tuple d h
        Magic d h -> Tuple d h
  hitOrMiss <- checkHitOrMiss $ hit - enemyFlee
  if hitOrMiss then do
    let actualDamage = if dmg - enemyDefense < 0 then 0 else dmg - enemyDefense
    log $ show actualDamage <> "のダメージ！"
    let newEnemyHp = if enemyHp - actualDamage < 0 then 0 else enemyHp - actualDamage
    pure $ enemy{ enemyHp = newEnemyHp }
  else do
    log "攻撃を外した！"
    pure enemy

damagePlayer :: Enemy -> Player -> Effect Player
damagePlayer { enemyHit, enemyAttack } player@{ playerHp, playerDefense } = do
  hitOrMiss <- checkHitOrMiss enemyHit
  if hitOrMiss then do
    let injury = if enemyAttack - playerDefense < 0 then 0 else enemyAttack - playerDefense
    log $ show injury <> "のダメージ！"
    let newPlayerHp = if playerHp - injury < 0 then 0 else playerHp - injury
    pure player{ playerHp = newPlayerHp }
  else do
    log "攻撃を外した！"
    pure player
  
checkHitOrMiss ∷ Int → Effect Boolean
checkHitOrMiss hit = randomInt 0 99 >>= \i -> pure $ i < hit