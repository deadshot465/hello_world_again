module Kex2.Kex2 where

import Prelude
import Data.Text (unpack)
import Shared.Player (Player(..))
import Shared.Constants (playerInitialHp, playerInitialDefense)
import Kex2.Kex2Battle (gameLoop)

run :: IO ()
run = do
  putStrLn "冒険が今始まる！"
  let player = Player{ playerHp = playerInitialHp, playerDefense = playerInitialDefense }
  gameResult <- gameLoop player 0 1
  putStrLn $ unpack gameResult