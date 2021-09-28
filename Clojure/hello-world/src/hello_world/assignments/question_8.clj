(ns hello-world.assignments.question-8
  (:require [hello-world.shared.question :as question]
            [hello-world.assignments.question-7 :as question-7 :only get-numbers]
            [hello-world.assignments.question-8-adventure :as adventure]))

(deftype K08 []
  question/Question

  (question-1 [_]
    (let [numbers (question-7/get-numbers 3)]
      (let [count (count numbers)]
        (println "どちらを調べますか？")
        (println "（０：最大値　１：最小値）＞")
        (let [choice (-> (read-line)
                         (Integer/parseInt))]
          (let [result (if (= choice 0) {:text "最大値" :value (apply max numbers)}
                                        {:text "最小値" :value (apply min numbers)})]
            (printf "%dつの中で%sは%d\n" count (result :text) (result :value)))))))

  (question-2 [_]
    (println "冒険が今始まる！")
    (let [player-hp (+ 200 (rand-int 101))]
      (println (adventure/game-loop player-hp))))

  (question-3 [_]
    ())

  (question-4 [_]
    ()))