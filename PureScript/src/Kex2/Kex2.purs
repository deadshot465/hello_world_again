module Kex2.Kex2
  ( run
  )
  where

import Prelude

import Effect.Aff (Aff)
import Effect.Class.Console (log)
import Kex2.Kex2Battle (gameLoop)
import Readline (closeAndExit)
import Shared.Constants (playerInitialDefense, playerInitialHp)


run ∷ Aff Unit
run = do
  log "冒険が今始まる！"
  let player = { playerHp: playerInitialHp, playerDefense: playerInitialDefense }
  gameResult <- gameLoop player 0 1
  log gameResult
  closeAndExit