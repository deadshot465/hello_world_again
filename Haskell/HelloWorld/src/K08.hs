module K08 where

import Prelude
import Question (Question(..))
import K07 (getNumbers)
import Utility (getInt, getRandomInt)
import K08_Adventure (gameLoop)

data K08 = K08

instance Question K08 where
  question1 _ = do
    numbers <- getNumbers 3
    let count = length numbers
    putStrLn "どちらを調べますか？"
    putStrLn "（０：最大値　１：最小値）＞"
    choice <- getInt
    let result = foldr (case choice of
          0 -> max
          _ -> min) (head numbers) numbers
    putStrLn $ show count <> "つの中で" <> (if choice == 0 then "最大値" else "最小値") <> "は" <> show result

  question2 _ = do
    putStrLn "冒険が今始まる！"
    playerHp <- getRandomInt 100 >>= \n -> pure $ n + 200
    result <- gameLoop playerHp
    putStrLn result

  question3 _ = pure ()

  question4 _ = pure ()
