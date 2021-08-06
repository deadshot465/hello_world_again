module K01 (K01(..)) where
  
import Prelude

import Effect.Aff (launchAff_)
import Effect.Class.Console (log)
import Question (class Question)
import Readline (closeAndExit)

data K01 = K01

instance Question K01 where
  question1 _ = launchAff_ do
    log "Hello World!　ようこそPureScript言語の世界へ！"
    closeAndExit

  question2 _ = launchAff_ do
    log "Hello World!"
    log "ようこそ"
    log "PureScript言語の世界へ！"
    closeAndExit

  question3 _ = launchAff_ do
    log $ "整数：" <> show 12345
    log $ "実数：" <> show 123.456789
    log $ "文字：" <> "A"
    log $ "文字列：" <> "ABCdef"
    closeAndExit

  question4 _ = launchAff_ do
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
    closeAndExit