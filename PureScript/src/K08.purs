module K08 (K08(..)) where
  
import Prelude

import Data.Int (fromString)
import Data.List (foldr, head, length)
import Data.Maybe (fromMaybe)
import Data.Tuple (Tuple(..))
import Effect.Aff (launchAff_)
import Effect.Class.Console (log)
import K07 (getNumbers)
import K08Adventure (gameLoop)
import Question (class Question)
import Readline (closeAndExit, getNumber)
import Util (randomAff)

data K08 = K08

instance Question K08 where
  question1 _ = launchAff_ do
    numbers <- getNumbers 3
    let count = length numbers
    log "どちらを調べますか？"
    choice <- getNumber "（０：最大値　１：最小値）＞" 0 fromString
    let Tuple text value = case choice of
                            0 -> Tuple "最大値" (foldr max (fromMaybe 0 $ head numbers) numbers)
                            _ -> Tuple "最小値" (foldr min (fromMaybe 0 $ head numbers) numbers)
    log $ show count <> "つの中で" <> text <> "は" <> show value
    closeAndExit

  question2 _ = launchAff_ do
    log "冒険が今始まる！"
    playerHp <- randomAff 0 100 >>= \n -> pure $ n + 200
    result <- gameLoop playerHp
    log result
    closeAndExit

  question3 _ = pure unit

  question4 _ = pure unit