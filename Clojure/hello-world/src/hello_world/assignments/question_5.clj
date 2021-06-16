(ns hello-world.assignments.question-5
  (:require [hello-world.shared.question :as question]
            [hello-world.assignments.question-2 :as question-2 :only Golem]))

(defn input-damage [choice]
              (cond (= choice 1) (+ 60 (rand-int 40))
                    (= choice 2) (+ 30 (rand-int 100))
                    (= choice 3) (+ 20 (rand-int 180))
                    :else (do (print "攻撃手段を選択してください（1．攻撃　2．特技　3．魔法）＞")
                              (flush)
                              (recur (-> (read-line)
                                         (Integer/parseInt))))))

(deftype K05 []
  question/Question
  (question-1 [_]
    (let [salary 19.0
          age 22]
      (loop [salary' salary
             age' age]
        (if (< salary' 50.0) (recur (* 1.035 salary') (inc age'))
                             (printf "%d歳で月給%f万円\n" age' salary')))))
  (question-2 [_]
    (loop [choice 0]
      (if (not (= choice 1)) (do (println "起きろ〜")
                                 (print "1．起きた　2．あと5分…　3．Zzzz…\t入力：")
                                 (flush)
                                 (recur (-> (read-line)
                                            (Integer/parseInt))))
                             (println "よし、学校へ行こう！"))))
  (question-3 [_]
    (loop [choice 0]
      (if (not (= choice 1)) (do (println "起きろ〜")
                                 (print "1．起きた　2．あと5分…　3．Zzzz…\t入力：")
                                 (flush)
                                 (recur (-> (read-line)
                                            (Integer/parseInt))))
                             (do (println "よし、学校へ行こう！")
                                 (recur 0)))))
  (question-4 [_]
    (let [golem (question-2/->Golem (+ 300 (rand-int 200)) 80 50)
          player-hp (+ 200 (rand-int 100))]
      (printf "ゴーレム　（HP：%d　防御力：%d）\n" (.hp golem) (.defense golem))
      (loop [golem' golem
             player-hp' player-hp]
        (cond (and (= (.hp golem') 0) (not (= player-hp' 0))) (println "ゴーレムを倒しました！")
              (and (not (= (.hp golem') 0)) (= player-hp' 0)) (println "あなたはゴーレムに負けました！ゲームオーバー！")
              :else (do (println (str "ゴーレム残りHP：" (.hp golem')))
                        (let [damage (input-damage 0)]
                          (printf "基礎攻撃力は%dです。\n" damage)
                          (let [damage (if (<= (- damage (.defense golem')) 0) 0 (- damage (.defense golem')))]
                            (if (= damage 0) (do (println "ゴーレム：「ハハハハハ、情けないな！貴様は弱すぎる！」")
                                                 (println (str "ゴーレムがあなたを攻撃しました！攻撃値：" (.attack golem')))
                                                 (let [hp (if (< (- player-hp' (.attack golem')) 0) 0 (- player-hp' (.attack golem')))]
                                                   (println (str "あなたの残りHPは：" hp))
                                                   (recur golem' hp)))
                                             (do (printf "ダメージは%dです。\n" damage)
                                                 (let [hp (if (< (- (.hp golem') damage) 0) 0 (- (.hp golem') damage))]
                                                   (printf "残りのHPは%dです。\n" hp)
                                                   (recur (question-2/->Golem hp (.defense golem') (.attack golem')) player-hp'))))))))))))
