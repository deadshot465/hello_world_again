(ns hello-world.shared.enemy
  (:require [hello-world.shared.constants :refer :all]))

(defrecord Enemy [level name hp defense attack flee hit])

(defn make-enemy [ordinal]
  (case ordinal
    0 (do (let [level (rand-int max-golem-level)]
            (->Enemy level "ゴーレム" (+ 100 (* level 50)) (+ 40 (* level 10)) (+ 40 (* level 10)) golem-flee golem-hit)))
    1 (do (let [level (rand-int max-goblin-level)]
            (->Enemy level "ゴブリン" (+ 75 (* level 30)) (+ 20 (* level 5)) (+ 20 (* level 5)) goblin-flee goblin-hit)))
    2 (do (let [level (rand-int max-slime-level)]
            (->Enemy level "スライム" (+ 50 (* level 10)) (+ 10 (* level 2)) (+ 10 (* level 2)) slime-flee slime-hit)))
    (make-enemy 0)))