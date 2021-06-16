(ns hello-world.assignments.question-1
  (:require [hello-world.shared.question :as question]))

(deftype K01 []
  question/Question
  (question-1 [_] (println "Hello World!　ようこそClojure言語の世界へ！"))
  (question-2 [_] (println "Hello World!")
    (println "ようこそ")
    (println "Clojure言語の世界へ！"))
  (question-3 [_] (println (str "整数：" 12345))
    (println (str "実数：" 123.456789))
    (println (str "文字：" \A))
    (println (str "文字列：" "ABCdef")))
  (question-4 [_]
    (println "              ##")
    (println "             #  #")
    (println "             #  #")
    (println "            #    #")
    (println "           #      #")
    (println "         ##        ##")
    (println "       ##            ##")
    (println "    ###                ###")
    (println " ###       ##    ##       ###")
    (println "##        #  #  #  #        ##")
    (println "##         ##    ##         ##")
    (println " ##     #            #     ##")
    (println "  ###     ##########     ###")
    (println "     ###              ###")
    (println "        ##############")))
