(ns hello-world.assignments.question-6
  (:require [hello-world.shared.question :as question]
            [hello-world.assignments.question-2 :as question-2 :only Golem]))

(defn get-ages []
  (loop [no 0
         amount 5
         acc '()]
    (if (= amount 0) acc
                     (do (printf "%d人目の年齢を入力して下さい：" (+ no 1))
                         (flush)
                         (recur (+ no 1) (- amount 1) (cons (-> (read-line)
                                                                (Integer/parseInt)) acc))))))

(defn make-upper-pyramid [levels]
  (loop [current 0
         levels' levels
         acc '()]
    (if (= levels' 0) acc
                      (recur (+ current 1) (- levels' 1) (cons (apply str (take (+ current 1) (repeat "*"))) acc)))))

(defn make-lower-pyramid [levels]
  (loop [levels' levels
         acc '()]
    (if (= levels' 0) acc
                      (recur (- levels' 1) (cons (apply str (take levels' (repeat "*"))) acc)))))

(defn make-special-pyramid [levels]
  (loop [amount-of-stars levels
         amount-of-spaces 0
         acc '()]
    (if (= amount-of-stars 0) acc
                      (recur (- amount-of-stars 1) (+ amount-of-spaces 1) (cons
                                                                            (str
                                                                              (apply str (take amount-of-spaces (repeat " ")))
                                                                              (apply str (take amount-of-stars (repeat "*")))) acc)))))

(defn count-tens [remains] (quot remains 10))

(defn count-fifties [amount remains arr]
  (if (< amount 0) arr
                   (recur (- amount 1) remains (cons (list amount (count-tens (- remains (* amount 50)))) arr))))

(defn count-hundreds [amount remains arr]
  (if (< amount 0) arr
                   (do (let [remains' (- remains (* amount 100))]
                         (let [arr' (->> (count-fifties (quot remains' 50) remains' '())
                                         (map (fn [x] (list amount (first x) (second x)))))]
                           (recur (- amount 1) remains (concat arr' arr)))))))

(defn count-combinations [amount]
  (count-hundreds (quot amount 100) amount '()))

(defn print-one-to-ten [num arr]
  (if (= num 0) arr
                (recur (- num 1) (cons num arr))))

(defn multiplications [i j arr]
  (if (= j 0) arr
              (recur i (- j 1) (cons (* i j) arr))))

(defn calculations [i arr]
  (if (= i 0) arr
              (recur (- i 1) (cons (multiplications i 9 '()) arr))))

(deftype K06 []
  question/Question
  (question-1 [_]
    (let [ages (get-ages)]
      (let [count (count ages)
            total-ages (reduce (fn [acc elem] (+ acc elem)) 0 ages)]
        (println (str count "人の平均年齢は" (/ (float total-ages) (float count)) "です。")))))
  (question-2 [_]
    (->> (make-upper-pyramid 8)
         (reverse)
         (clojure.string/join "\n")
         (println))
    (newline)

    (->> (make-lower-pyramid 8)
         (reverse)
         (clojure.string/join "\n")
         (println))
    (newline)

    (->> (make-special-pyramid 8)
         (clojure.string/join "\n")
         (println)))
  (question-3 [_]
    (let [combinations (->> (count-combinations 370)
                            (map (fn [x] (str "10円の硬貨" (nth x 2) "枚 50円の硬貨" (second x) "枚 100円の硬貨" (first x) "枚\n"))))]
      (-> (clojure.string/join "\n" combinations)
          (println))
      (println (str "\n以上" (count combinations) "通りを発見しました。\n"))))
  (question-4 [_]
    (print "\t|\t")
    (flush)
    (->> (print-one-to-ten 9 '())
         (clojure.string/join "\t")
         (println))
    (println (apply str (take 90 (repeat "-"))))
    (->> (calculations 9 '())
         (map-indexed (fn [index elem]
                        (let [inner-list (->> (map (fn [y] (str y)) elem)
                                              (clojure.string/join "\t"))]
                          (str (+ index 1) "\t|\t" inner-list))))
         (clojure.string/join "\n")
         (println))))