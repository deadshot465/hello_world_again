module Main where

import Question (execute)
import K01 (K01(..))
import K02 (K02(..))

main :: IO ()
main = execute k02 4

k01 :: K01
k01 = K01

k02 = K02