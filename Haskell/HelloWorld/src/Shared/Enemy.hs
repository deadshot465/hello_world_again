module Shared.Enemy where

import Prelude
import Data.Text (Text, pack)
import Utility (getRandomInteger)
import Shared.Constants (maxGolemLevel, golemHit, golemFlee, maxGoblinLevel, goblinHit, goblinFlee, maxSlimeLevel, slimeHit, slimeFlee)

data Enemy = Enemy
  { enemyLevel :: Integer
  , enemyHp :: Integer
  , enemyDefense :: Integer
  , enemyAttack :: Integer
  , enemyHit :: Integer 
  , enemyFlee :: Integer 
  , enemyName :: Text
  }

data EnemyType
  = Golem Enemy
  | Goblin Enemy
  | Slime Enemy

makeEnemy :: (Eq t, Num t) => t -> IO EnemyType
makeEnemy 0 = do
  level <- getRandomInteger maxGolemLevel
  pure $ Golem $ Enemy
    { enemyLevel = level
    , enemyHp = level * 50 + 100
    , enemyDefense = level * 10 + 40
    , enemyAttack = calculateGolemAttack level
    , enemyHit = golemHit 
    , enemyFlee = golemFlee 
    , enemyName = pack "ゴーレム"
    }
makeEnemy 1 = do
  level <- getRandomInteger maxGoblinLevel 
  pure $ Goblin $ Enemy
    { enemyLevel = level
    , enemyHp = level * 30 + 75
    , enemyDefense = level * 5 + 20
    , enemyAttack = level * 5 + 20
    , enemyHit = goblinHit 
    , enemyFlee = goblinFlee  
    , enemyName = pack "ゴブリン"
    }
makeEnemy 2 = do
  level <- getRandomInteger maxSlimeLevel  
  pure $ Goblin $ Enemy
    { enemyLevel = level
    , enemyHp = level * 10 + 50
    , enemyDefense = level * 2 + 10
    , enemyAttack = level * 2 + 10
    , enemyHit = slimeHit
    , enemyFlee = slimeFlee
    , enemyName = pack "スライム"
    }
makeEnemy _ = makeEnemy 0


calculateGolemAttack :: Integral a => a -> Integer
calculateGolemAttack level = toInteger $ level * 10 + 40