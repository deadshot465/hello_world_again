module K01 (K01(..)) where

import Prelude
import Question (Question(..))

data K01 = K01

instance Question K01 where
  question1 _ = putStrLn "Hello World!　ようこそHaskell言語の世界へ！"
  question2 _ = do
    putStrLn "Hello World!"
    putStrLn "ようこそ"
    putStrLn "Haskell言語の世界へ！"
  question3 _ = do
    putStrLn $ "整数：" <> show 12345
    putStrLn $ "実数：" <> show 123.456789
    putStrLn $ "文字：" <> "A"
    putStrLn $ "文字列：" <> "ABCdef"
  question4 _ = do
    putStrLn "              ##"
    putStrLn "             #  #"
    putStrLn "             #  #"
    putStrLn "            #    #"
    putStrLn "           #      #"
    putStrLn "         ##        ##"
    putStrLn "       ##            ##"
    putStrLn "    ###                ###"
    putStrLn " ###       ##    ##       ###"
    putStrLn "##        #  #  #  #        ##"
    putStrLn "##         ##    ##         ##"
    putStrLn " ##     #            #     ##"
    putStrLn "  ###     ##########     ###"
    putStrLn "     ###              ###"
    putStrLn "        ##############"