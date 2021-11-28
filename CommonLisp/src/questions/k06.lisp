(defpackage :k06
    (:use :cl)
    (:export #:question-1 #:question-2 #:question-3 #:question-4))

(in-package :k06)

(defun question-1 () 
    (let ((ages '()))
        (dotimes (i 5)
            (format t "~a人目の年齢を入力して下さい：" (+ i 1))
            (finish-output)
            (push (coerce (parse-integer (read-line) :junk-allowed t) 'single-float) ages))
        (format t "~a人の平均年齢は~aです。~%"
            (length ages) (/ (reduce #'+ ages) (length ages)))))

(defun question-2 ()
    (loop for i from 1 to 8
          do (loop for j from 1 to i
                   do (format t "*"))
          do (format t "~%"))
    (format t "~%")
    (loop for i from 9 above 1
          do (loop for j from 1 below i
                   do (format t "*"))
          do (format t "~%"))
    (format t "~%")
    (loop for i from 9 above 1
          do (loop for j from 1 below (- i 1)
                   do (format t " "))
          do (loop for k from 9 downto i
                   do (format t "*"))
          do (format t "~%"))
    (format t "~%"))

(defun question-3 ()
    (let ((total 370)
        (count 0))
        (loop for i from 0 to (floor (/ total 100))
              do (loop for j from 0 to (floor (/ total 50))
                       do (loop for k from 0 to (floor (/ total 10))
                                when (= (+ (* 100 i) (* 50 j) (* 10 k)) total)
                                do (format t "10円の硬貨~a枚 50円の硬貨~a枚 100円の硬貨~a枚~%" k j i)
                                when (= (+ (* 100 i) (* 50 j) (* 10 k)) total)
                                do (incf count))))
        (format t "~%以上~a通りを発見しました。~%" count)))

(defun question-4 ()
    (format t "~c|~c" #\tab #\tab)
    (loop for x from 1 to 9
          do (format t "~a~c" x #\tab))
    (format t "~%")
    (dotimes (i 85) (format t "-"))
    (format t "~%")
    (loop for x from 1 to 9
          do (format t "~a~c|~c" x #\tab #\tab)
          do (loop for y from 1 to 9
                   do (format t "~a~c" (* x y) #\tab))
          do (format t "~%")))