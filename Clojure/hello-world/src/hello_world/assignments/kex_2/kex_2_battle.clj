(ns hello-world.assignments.kex-2.kex-2-battle
  (:require [hello-world.shared.enemy :refer :all]
            [hello-world.shared.player :refer :all]
            [hello-world.shared.constants :refer :all]))

(defn select-attack [choice]
  (case choice
    1 {:dmg (+ 60 (rand-int 41)) :hit attack-hit}
    2 {:dmg (+ 30 (rand-int 101)) :hit skill-hit}
    3 {:dmg (+ 20 (rand-int 181)) :hit magic-hit}
    (select-attack 1)))

(defn check-hit-or-miss [hit]
  (< (rand-int 101) hit))

(defn damage-enemy [attack-method enemy]
  (let [dmg (:dmg attack-method)
        hit (:hit attack-method)]
    (let [hit-or-miss (check-hit-or-miss hit)]
      (if hit-or-miss (do
                        (let [actual-damage (if (< (- dmg (.defense enemy)) 0) 0
                                                                               (- dmg (.defense enemy)))]
                          (println (str actual-damage "のダメージ！"))
                          (let [new-enemy-hp (if (< (- (.hp enemy) actual-damage) 0) 0
                                                                                     (- (.hp enemy) actual-damage))]
                            (->Enemy (.level enemy) (.name enemy) new-enemy-hp (.defense enemy) (.attack enemy) (.flee enemy) (.hit enemy)))))
                      (do (println "攻撃を外した！")
                          enemy)))))

(defn damage-player [enemy player]
  (let [hit-or-miss (check-hit-or-miss (.hit enemy))]
    (if hit-or-miss (do (let [injury (if (< (- (.attack enemy) (.defense player)) 0) 0
                                                                                     (- (.attack enemy) (.defense player)))]
                          (println (str injury "のダメージ！"))
                          (let [new-player-hp (if (< (- (.hp player) injury) 0) 0
                                                                                (- (.hp player) injury))]
                            (->Player new-player-hp (.defense player)))))
                    (do (println "攻撃を外した！")
                        player))))

(defn battle-loop [enemy player]
  (cond
    (<= (.hp enemy) 0) (do (println (str (.name enemy) "Lv." (+ (.level enemy) 1) "を倒した！"))
                           {:result :continue :player player})
    (<= (.hp player) 0) (do (println (str "あなたは" (.name enemy) "に負けました！"))
                            {:result :end :message "ゲームオーバー！"})
    :else (do (println (str (.name enemy) " 残りHP：" (.hp enemy)))
              (print "武器を選択してください（１．攻撃　２．特技　３．魔法）＞")
              (flush)
              (let [choice (-> (read-line)
                               (Integer/parseInt))]
                (let [attack-method (select-attack choice)]
                  (let [new-enemy (damage-enemy attack-method enemy)]
                    (println (str (.name enemy) "の攻撃！"))
                    (let [new-player (damage-player enemy player)]
                      (if (> (.hp new-player) 0) (do (println (str "プレイヤー残りHP：" (.hp new-player)))
                                                     (battle-loop new-enemy new-player))
                                                 (battle-loop new-enemy new-player)))))))))

(defn engage-battle [enemy player]
  (println (str (.name enemy) "Lv." (+ (.level enemy) 1) "が現れた！"))
  (battle-loop enemy player))

(defn game-loop [player]
  (loop [inner-player player
         kills 0
         choice 1]
    (cond
      (= choice 0) (str "リ〇ミト！\n戦闘回数：" kills "回　残りHP：" (.hp inner-player))
      (<= (.hp inner-player) 0) (recur inner-player kills 0)
      :else (do (println (str "現HP：" (.hp inner-player)))
                (print "奥に進みますか？（１：奥に進む　０．帰る）＞")
                (flush)
                (let [new-choice (-> (read-line)
                                 (Integer/parseInt))]
                  (case new-choice
                    0 (recur inner-player kills new-choice)
                    (let [ordinal (rand-int 3)]
                      (let [enemy (make-enemy ordinal)]
                        (let [result (engage-battle enemy inner-player)]
                          (case (:result result)
                            :end (do (println (:message result))
                                     (recur (->Player 0 (.defense inner-player)) kills 0))
                            :continue (let [new-player (:player result)]
                                        (recur new-player (+ kills 1) 1))))))))))))