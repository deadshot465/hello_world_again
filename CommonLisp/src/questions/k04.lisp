(defpackage :k04
    (:use :cl)
    (:export #:question-1 #:question-2 #:question-3 #:question-4))

(in-package :k04)

(defun question-1 () 
    (print "年齢を入力してください。＞")
    (finish-output)
    (let ((age (parse-integer (read-line) :junk-allowed t)))
        (print (if (or (< age 3) (>= age 70)) "入場料金無料です。" "通常料金です。"))))

(defun question-2 ()
    (print "性別を選択してください。（０：男性　１：女性）＞")
    (finish-output)
    (let ((gender (parse-integer (read-line) :junk-allowed t)))
        (print (case gender
        (0 "あら、格好良いですね。")
        (1 "あら、モデルさんみたいですね。")
        (otherwise "そんな選択肢はありません。")))))

(defun question-3 ()
    (print "年齢を入力してください。＞")
    (finish-output)
    (let ((age (parse-integer (read-line) :junk-allowed t)))
        (print
            (cond
            ((or (< age 3) (>= age 70)) "入場料金無料です。")
            ((and (>= age 3) (<= age 15)) "子供料金で半額です。")
            ((and (>= age 60) (< age 70)) "シニア割引で一割引きです。")
            (t "通常料金です。")))))

(defun question-4 ()
    (print "＊＊＊おみくじプログラム＊＊＊")
    (print "おみくじを引きますか　（はい：１　いいえ：０）＞")
    (finish-output)
    (let ((choice (parse-integer (read-line) :junk-allowed t))
        (oracle (random 5)))
        (if (>= choice 1)
            (print (case oracle
                (0 "大吉　とってもいいことがありそう！！")
                (1 "中吉　きっといいことあるんじゃないかな")
                (2 "小吉　少しぐらいはいいことあるかもね")
                (3 "凶　今日はおとなしくておいた方がいいかも")
                (4 "大凶　これじゃやばくない？早く家に帰った方がいいかも")
                (otherwise "")))
            (print ""))))