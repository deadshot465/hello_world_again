module Utility where

import Prelude
import System.Random (getStdRandom, Random (randomR))

getInt :: IO Int
getInt = getLine >>= \s -> pure (read s :: Int)

getRandomInt :: Int -> IO Int
getRandomInt upper = getStdRandom (randomR (0, upper)) :: IO Int