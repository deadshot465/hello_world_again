(ns hello-world.assignments.question-2
  (:require [hello-world.shared.question :as question]))

(defrecord Golem [hp defense attack])

(deftype K02 []
  question/Question
  (question-1 [_]
    (let [seisuu 3
          jissuu 2.6
          moji \A]
      (println (str "変数seisuuの値は" seisuu))
      (println (str "変数jissuuの値は" jissuu))
      (println (str "変数mojiの値は" moji))))
  (question-2 [_] (println "一つ目の整数は？")
    (let [number-1 (-> (read-line)
                       (Integer/parseInt))]
      (println "二つ目の整数は？")
      (let [number-2 (-> (read-line)
                         (Integer/parseInt))]
        (printf "%d÷%d=%d...%d\n" number-1 number-2 (quot number-1 number-2) (rem number-1 number-2)))))
  (question-3 [_] (println "一つ目の商品の値段は？")
    (let [price-A (-> (read-line)
                      (Float/parseFloat))]
      (println "個数は？")
      (let [amount-A (-> (read-line)
                         (Float/parseFloat))]
        (println "二つ目の商品の値段は？")
        (let [price-B (-> (read-line)
                          (Float/parseFloat))]
          (println "個数は？")
          (let [amount-B (-> (read-line)
                             (Float/parseFloat))]
            (println (str "お支払いは税込み￥" (* (+ (* price-A amount-A) (* price-B amount-B)) 1.1))))))))
  (question-4 [_]
    (let [golem (->Golem 300 80 50)]
      (printf "ゴーレム　（HP：%d　防御力：%d）\n" (.hp golem) (.defense golem))
      (println (str "HP：" (.hp golem)))
      (print "今回の攻撃の値を入力してください＞")
      (flush)
      (let [damage (-> (read-line)
                       (Integer/parseInt))]
        (let [final-damage (if (> (- damage (.defense golem)) 0)
                             (- damage (.defense golem))
                             0)]
          (printf "ダメージは%dです。" final-damage)
          (let [golem (->Golem (- (.hp golem) final-damage) 80 50)]
            (printf "残りのHPは%dです。" (.hp golem))))))))
