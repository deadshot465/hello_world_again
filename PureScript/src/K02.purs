module K02 (K02(..)) where
  
import Prelude

import Effect.Class.Console (log)
import Question (class Question)

data K02 = K02

seisuu :: Int
seisuu = 3

jissuu :: Number
jissuu = 2.6

moji :: Char
moji = 'A'

instance Question K02 where
  question1 _ = do
    log $ "変数seisuuの値は" <> show seisuu
    log $ "変数jissuuの値は" <> show jissuu
    log $ "変数mojiの値は" <> show moji

  question2 _ = do
    log "一つ目の整数は？"

  question3 _ = do
    log $ "整数：" <> show 12345
    log $ "実数：" <> show 123.456789
    log $ "文字：" <> "A"
    log $ "文字列：" <> "ABCdef"

  question4 _ = do
    log "              ##"
    log "             #  #"
    log "             #  #"
    log "            #    #"
    log "           #      #"
    log "         ##        ##"
    log "       ##            ##"
    log "    ###                ###"
    log " ###       ##    ##       ###"
    log "##        #  #  #  #        ##"
    log "##         ##    ##         ##"
    log " ##     #            #     ##"
    log "  ###     ##########     ###"
    log "     ###              ###"
    log "        ##############"