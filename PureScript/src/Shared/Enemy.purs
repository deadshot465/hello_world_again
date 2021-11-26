module Shared.Enemy
  ( Enemy
  , EnemyType(..)
  , makeEnemy
  )
  where
  
import Prelude

import Effect (Effect)
import Effect.Random (randomInt)
import Shared.Constants (goblinFlee, goblinHit, golemFlee, golemHit, maxGoblinLevel, maxGolemLevel, maxSlimeLevel, slimeFlee, slimeHit)

type Enemy =
  { enemyLevel :: Int
  , enemyName :: String
  , enemyAttack :: Int
  , enemyDefense :: Int
  , enemyHit :: Int
  , enemyFlee :: Int
  , enemyHp :: Int
  }

data EnemyType
  = Golem Enemy
  | Goblin Enemy
  | Slime Enemy

makeEnemy ∷ Int → Effect EnemyType
makeEnemy 0 = do
  level <- randomInt 1 maxGolemLevel
  pure $ Golem $
    { enemyLevel: level
    , enemyName: "ゴーレム"
    , enemyAttack: level * 10 + 40
    , enemyDefense: level * 10 + 40
    , enemyHit: golemHit
    , enemyFlee: golemFlee
    , enemyHp: level * 50 + 100
    }
makeEnemy 1 = do
  level <- randomInt 1 maxGoblinLevel
  pure $ Goblin $
    { enemyLevel: level
    , enemyName: "ゴブリン"
    , enemyAttack: level * 5 + 20
    , enemyDefense: level * 5 + 20
    , enemyHit: goblinHit
    , enemyFlee: goblinFlee
    , enemyHp: level * 30 + 75
    }
makeEnemy 2 = do
  level <- randomInt 1 maxSlimeLevel
  pure $ Golem $
    { enemyLevel: level
    , enemyName: "スライム"
    , enemyAttack: level * 2 + 10
    , enemyDefense: level * 2 + 10
    , enemyHit: slimeHit
    , enemyFlee: slimeFlee
    , enemyHp: level * 10 + 50
    }
makeEnemy _ = makeEnemy 0