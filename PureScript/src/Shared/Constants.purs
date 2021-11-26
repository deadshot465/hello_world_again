module Shared.Constants
  ( attackHit
  , goblinFlee
  , goblinHit
  , golemFlee
  , golemHit
  , magicHit
  , maxGoblinLevel
  , maxGolemLevel
  , maxSlimeLevel
  , playerInitialDefense
  , playerInitialHp
  , skillHit
  , slimeFlee
  , slimeHit
  )
  where

playerInitialHp ∷ Int
playerInitialHp = 500

playerInitialDefense ∷ Int
playerInitialDefense = 30

attackHit ∷ Int
attackHit = 110

skillHit ∷ Int
skillHit = 100

magicHit ∷ Int
magicHit = 70

golemHit ∷ Int
golemHit = 75

golemFlee ∷ Int
golemFlee = 20

goblinHit ∷ Int
goblinHit = 85

goblinFlee ∷ Int
goblinFlee = 40

slimeHit ∷ Int
slimeHit = 95

slimeFlee ∷ Int
slimeFlee = 30

maxGolemLevel ∷ Int
maxGolemLevel = 5

maxGoblinLevel ∷ Int
maxGoblinLevel = 7

maxSlimeLevel ∷ Int
maxSlimeLevel = 9