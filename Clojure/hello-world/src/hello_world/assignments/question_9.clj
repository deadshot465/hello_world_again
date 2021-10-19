(ns hello-world.assignments.question-9
  (:require [hello-world.shared.question :as question]
            [hello-world.assignments.question-6 :as question-6 :only get-ages]))

(defn transform [xs acc]
  (reduce (fn [inner-acc student]
            (map-indexed (fn [idx score] (+ score (nth student idx))) inner-acc)) acc xs))

(defn input-numbers []
  (loop [n 1
         choice 0
         acc '()]
    (cond
      (< choice 0) acc
      (= n 100) acc
      :else (let [number (do (println (str n "件目の入力："))
                             (-> (read-line)
                                 (clojure.string/trim)
                                 (Integer/parseInt)))]
              (recur (+ n 1) number (cons number acc))))))

(defn question-5 []
  (let [input (input-numbers)]
    (println "----並び替え後----")
    (let [sorted (sort input)]
      (println (str sorted)))))

(deftype K09 []
  question/Question

  (question-1 [_]
    (let [ages (question-6/get-ages 3)]
      (println (apply str (take 90 (repeat "-"))))
      (let [count (float (count ages))
            total (float (reduce + 0 ages))]
        (let [scores (map-indexed (fn [idx age] (str (+ idx 1) "人目：" age "歳")) ages)]
          (println (clojure.string/join "\n" scores)))
        (println (str "平均年齢：" (/ total count) "歳")))))

  (question-2 [_]
    (let [numbers (list 8 3 12 7 9)]
      (print "元々の配列：")
      (println (clojure.string/join " " (map (fn [n] (str n)) numbers)))
      (flush)
      (println "逆順での表示：")
      (println (clojure.string/join " " (map (fn [n] (str n)) (reverse numbers))))))

  (question-3 [_]
    (newline)
    (let [student-scores (list (list 52 71 61 47) (list 6 84 81 20) (list 73 98 94 95))]
      (println "\t|\t科目A\t科目B\t科目C\t科目D")
      (println (apply str (take 65 (repeat "-"))))
      (let [result (map-indexed (fn [idx student]
                                  (let [prefix (str "学生" (+ idx 1) "\t|\t")
                                        all-scores (reduce (fn [acc score] (str acc score "\t")) "" student)]
                                    (str prefix all-scores "\n"))) student-scores)]
        (println result))))

  (question-4 [_]
    (newline)
    (let [student-scores (list (list 52 71 61 47) (list 6 84 81 20) (list 73 98 94 95))]
      (let [with-sum (map (fn [scores] (concat scores (list (reduce + 0 scores)))) student-scores)]
        (println "\t|\t科目A\t科目B\t科目C\t科目D\t|\t合計点")
        (println (apply str (take 65 (repeat "-"))))
        (let [result (map-indexed (fn [idx student]
                                    (let [prefix (str "学生" (+ idx 1) "\t|\t")
                                          last-score (last student)]
                                      (let [all-scores (reduce (fn [acc score] (if (= score last-score) (str acc "|\t" score "\t")
                                                                                                        (str acc score "\t"))) "" student)]
                                        (str prefix all-scores "\n")))) with-sum)]
          (println result)
          (let [average (transform with-sum (list 0 0 0 0 0))
                prefix "平均点\t|\t"]
            (let [all-scores (reduce (fn [acc score] (if (= score (last average)) (str acc "|\t" (/ score 3.0) "\t")
                                                                                  (str acc (/ score 3.0) "\t"))) "" average)]
              (println (str prefix all-scores))))))
      ))
  )