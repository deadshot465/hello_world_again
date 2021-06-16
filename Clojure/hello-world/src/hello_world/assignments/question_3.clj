(ns hello-world.assignments.question-3
  (:require [hello-world.shared.question :as question]))

(deftype K03 []
  question/Question
  (question-1 [_]
    (print "年齢を入力してください。＞")
    (flush)
    (let [age (-> (read-line)
                  (Integer/parseInt))]
      (if (< age 20) (println "未成年なので購入できません。"))))
  (question-2 [_]
    (print "身長を入力してください。＞")
    (flush)
    (let [height (-> (read-line)
                     (Float/parseFloat)
                     (* 0.01))]
      (print "体重を入力してください。＞")
      (flush)
      (let [weight (-> (read-line)
                       (Float/parseFloat))]
        (let [standard (-> (* height height)
                           (* 22.0))]
          (printf "あなたの標準体重は%fです。\n" standard)
          (cond (and (> weight standard) (> (* (/ (- weight standard) standard) 100.0) 14.0)) (println "太り気味です。")
                (and (< weight standard) (< (* (/ (- weight standard) standard) 100.0) -14.0)) (println "痩せ気味です。")
                :else (println "普通ですね。"))))))
  (question-3 [_]
    (let [random-number (rand-int 100)]
      (println "０から９９の範囲の数値が決定されました。")
      (print "決められた数値を予想し、この数値よりも大きな値を入力してください＞")
      (flush)
      (let [guess (-> (read-line)
                      (Integer/parseInt))]
        (printf "決められた数値は%dです。\n" random-number)
        (println (if (> guess random-number) "正解です。" "不正解です。")))))
  (question-4 [_]
    (let [random-number (rand-int 100)]
      (println "０から９９の範囲の数値が決定されました。")
      (print "決められた数値を予想し、この数値よりも大きな値を入力してください＞")
      (flush)
      (let [guess (-> (read-line)
                      (Integer/parseInt))]
        (printf "決められた数値は%dです。\n" random-number)
        (println (cond (or (< guess 0) (> guess 99)) "反則です！"
                       (and (> guess random-number) (<= (- guess random-number) 10)) "大正解です！"
                       (and (< guess random-number) (<= (- random-number guess) 10)) "惜しい！"
                       (= guess random-number) "お見事！"
                       :else (if (> guess random-number) "正解です。" "不正解です。")))))))
