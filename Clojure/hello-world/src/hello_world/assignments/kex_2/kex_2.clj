(ns hello-world.assignments.kex-2.kex-2
  (:require [hello-world.assignments.kex-2.kex-2-battle :refer :all]
            [hello-world.shared.player :refer :all]
            [hello-world.shared.constants :refer :all]))

(defn run-kex-2 []
  (println "冒険が今始まる！")
  (let [player (->Player player-initial-hp player-initial-defense)]
    (println (game-loop player))))
