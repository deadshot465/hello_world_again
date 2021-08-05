module K01 (K01(..)) where
  
import Prelude

import Effect.Class.Console (log)
import Question (class Question)

data K01 = K01

instance Question K01 where
  question1 _ = log "Hello World!　ようこそPureScript言語の世界へ！"

  question2 _ = do
    log "Hello World!"
    log "ようこそ"
    log "PureScript言語の世界へ！"

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