(ns hello-world.assignments.question-8-adventure
  (:require [hello-world.assignments.question-2 :as question-2 :only Golem]))

(defn select-attack [choice]
  (case choice
    1 {:attack-type :attack :damage (+ 65 (rand-int 36))}
    2 {:attack-type :skill :damage (+ 50 (rand-int 101))}
    3 {:attack-type :magic :damage (+ 33 (rand-int 168))}
    {:attack-type :attack :damage (+ 65 (rand-int 36))}))

(defn damage-player [golem-attack player-hp]
  (do (println "ゴーレム：「ハハハハハ、情けないな！貴様は弱すぎる！」")
      (printf "ゴーレムがあなたを攻撃しました！攻撃値：%d\n" golem-attack)
      (- player-hp golem-attack)))

(defn battle-loop [level g hp]
  (loop [golem-level level
         golem g
         player-hp hp]
    (if (= (.hp golem) 0) (do (printf "ゴーレムLv.%dを倒した！\n" (+ golem-level 1))
                              {:result :continue :hp player-hp :msg ""})
                          (do (printf "ゴーレムLv.%d残りHP：%d\n" (+ golem-level 1) (.hp golem))
                              (println "武器を選択してください（１．攻撃　２．特技　３．魔法）＞")
                              (let [base-damage ((select-attack (-> (read-line)
                                                                    (Integer/parseInt))) :damage)]
                                (let [actual-damage (if (<= (- base-damage (.defense golem)) 0) 0
                                                                                           (- base-damage (.defense golem)))]
                                  (printf "ダメージは%dです。\n" actual-damage)
                                  (if (<= actual-damage 0) (let [new-player-hp (damage-player (.attack golem) player-hp)]
                                                             (if (<= new-player-hp 0) {:result :end :hp new-player-hp :msg "あなたはゴーレムに負けました！"}
                                                                                      (do (printf "あなたの残りHPは：%d\n" new-player-hp)
                                                                                          (recur golem-level golem new-player-hp))))
                                                           (do (let [new-golem-hp (if (<= (- (.hp golem) actual-damage) 0) 0
                                                                                                                           (- (.hp golem) actual-damage))]
                                                                 (recur golem-level (question-2/->Golem new-golem-hp (.defense golem) (.attack golem)) player-hp))))))))))

(defn engage-battle [player-hp]
  (let [golem-level (rand-int 10)]
    (let [golem (question-2/->Golem (+ 100 (* golem-level 50)) (+ 40 (* golem-level 10)) (+ 30 (* golem-level 10)))]
      (do (printf "ゴーレムLv.%dが現れた！\n" (+ golem-level 1))
          (battle-loop golem-level golem player-hp)))))

(defn game-loop [hp]
  (loop [player-hp hp]
    (if (= player-hp 0) "ゲームオーバー！"
                        (do (printf "あなたのHP：%d\n" player-hp)
                            (println "奥に進みますか？（１：奥に進む　０．帰る）＞")
                            (let [choice (-> (read-line)
                                             (Integer/parseInt))]
                              (if (= choice 0) "リレ〇ト！"
                                               (do (let [result (engage-battle player-hp)]
                                                     (let [actual-result (result :result)]
                                                       (case actual-result
                                                         :continue (recur (result :hp))
                                                         :end (do (println (result :msg))
                                                                  (recur 0))))))))))))