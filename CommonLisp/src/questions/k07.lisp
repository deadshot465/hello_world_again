(defpackage :k07
    (:use :cl)
    (:export #:question-1 #:question-2 #:question-3 #:question-4))

(in-package :k07)

(defun question-1 () 
    (format t "メッセージを表示しますか？（０：終了する　１：表示する）＞")
    (finish-output)
    (let ((choice (parse-integer (read-line) :junk-allowed t)))
        (flet ((show-message ()
            (format t "Hello World!~%")
            (format t "ようこそ~%")
            (format t "Common Lispの世界へ！~%")
            (finish-output)))
            (loop for c = choice then (parse-integer (read-line) :junk-allowed t)
                  when (/= c 0)
                  do (progn
                    (show-message)
                    (format t "メッセージを表示しますか？（０：終了する　１：表示する）＞")
                    (finish-output))
                  when (= c 0)
                  return :end))))

(defun get-numbers (count)
    (let ((numbers '()))
        (dotimes (i count)
            (format t "~aつ目の値を入力してください。＞" (1+ i))
            (finish-output)
            (push (parse-integer (read-line) :junk-allowed t) numbers))
        numbers))

(defun question-2 ()
    (let* ((numbers (get-numbers 3))
        (count (length numbers))
        (max-value (apply #'max numbers)))
        (format t "~aつの中で最大値は~a~%" count max-value)))

(defun question-3 ()
    (format t "年齢を入力して下さい。＞")
    (finish-output)
    (flet ((get-age-tier (age)
        (cond
            ((or (< age 3) (>= age 70)) :free)
            ((and (<= age 15) (>= age 3)) :half)
            ((and (>= age 60) (< age 70)) :ten-percent-off)
            ((<= age 0) :error)
            (t :normal))))
            (let* ((age (parse-integer (read-line) :junk-allowed t))
                (age-tier (get-age-tier age)))
                (format t (case age-tier
                    (:error "不適切な値が入力されました。")
                    (:free "入場料金無料です。")
                    (:half "子供料金で半額です。")
                    (:ten-percent-off "シニア割引で１割引きです。")
                    (otherwise "通常料金です。"))))))

(defun question-4 ()
    )