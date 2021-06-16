(ns hello-world.assignments.question-4
  (:require [hello-world.shared.question :as question]))

(deftype K04 []
  question/Question
  (question-1 [_]
    (print "年齢を入力してください。＞")
    (flush)
    (let [age (-> (read-line)
                  (Integer/parseInt))]
      (if (or (< age 3) (>= age 70)) (println "入場料金無料です。") (println "通常料金です。"))))
  (question-2 [_]
    (print "性別を選択してください。（０：男性　１：女性）＞")
    (flush)
    (let [choice (-> (read-line)
                     (Integer/parseInt))]
      (cond (= choice 0) (println "あら、格好良いですね。")
            (= choice 1) (println "あら、モデルさんみたいですね。")
            :else (println "そんな選択肢はありません。"))))
  (question-3 [_]
    (print "年齢を入力してください。＞")
    (flush)
    (let [age (-> (read-line)
                  (Integer/parseInt))]
      (cond (or (< age 3) (>= age 70)) (println "入場料金無料です。")
            (and (>= age 3) (<= age 15)) (println "子供料金で半額です。")
            (and (>= age 60) (< age 70)) (println "シニア割引で一割引きです。")
            :else (println "通常料金です。"))))
  (question-4 [_]
    (println "＊＊＊おみくじプログラム＊＊＊")
    (print "おみくじを引きますか　（はい：１　いいえ：０）＞")
    (flush)
    (let [choice (-> (read-line)
                     (Integer/parseInt))]
      (if (>= choice 1)
        (let [result (rand-int 5)]
          (println (cond (= result 0) "大吉　とってもいいことがありそう！！"
                         (= result 1) "中吉　きっといいことあるんじゃないかな"
                         (= result 2) "小吉　少しぐらいはいいことあるかもね"
                         (= result 3) "凶　今日はおとなしくておいた方がいいかも"
                         (= result 4) "大凶　これじゃやばくない？早く家に帰った方がいいかも")))))))
