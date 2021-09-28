(ns hello-world.assignments.question-7
  (:require [hello-world.shared.question :as question]))

(defn show-texts []
  (println "Hello World!")
  (println "ようこそ")
  (println "Clojureの世界へ！"))

(defn get-numbers [count]
  (loop [acc '()
         no 0
         inner-count count]
    (if (= inner-count 0) acc
                    (do (printf "%dつ目の値を入力してください。＞" (+ no 1))
                        (flush)
                        (recur (cons (-> (read-line)
                                         (Integer/parseInt)) acc) (+ no 1) (- inner-count 1))))))

(defn get-age-tier [age]
  (cond
    (<= age 0) :error
    (or (< age 3) (>= age 70)) :free
    (and (>= age 3) (<= age 15)) :half
    (and (>= age 60) (< age 70)) :ten-percent-off
    :else :normal))

(deftype K07 []
  question/Question
  (question-1 [_]
    (println "メッセージを表示しますか？（０：終了する　１：表示する）＞")
    (let [choice (-> (read-line)
                     (Integer/parseInt))]
      (loop [c choice]
        (if (= c 0) ()
                    (do (show-texts)
                        (println "メッセージを表示しますか？（０：終了する　１：表示する）＞")
                        (recur (-> (read-line)
                                   (Integer/parseInt)))))))
    )

  (question-2 [_]
    (let [numbers (get-numbers 3)]
      (let [count (count numbers)]
        (let [max-value (apply max numbers)]
          (printf "%dつの中で最大値は%d" count max-value)))))

  (question-3 [_]
    (println "年齢を入力して下さい。＞")
    (let [age (-> (read-line)
                  (Integer/parseInt))]
      (let [tier (get-age-tier age)]
        (println (case tier
                   :error "不適切な値が入力されました。"
                   :free "入場料金無料です。"
                   :half "子供料金で半額です。"
                   :ten-percent-off "シニア割引で１割引きです。"
                   "通常料金です。")))))

  (question-4 [_]
    ()))