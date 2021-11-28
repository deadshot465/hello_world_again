(defpackage :app
    (:use :cl))

(in-package :app)

(defconstant BASE-PATH "")

(defparameter *FILE-NAMES* 
    (list "questions/k01.lisp"
            "questions/k02.lisp"
            "questions/k03.lisp"
            "questions/k04.lisp"
            "questions/k05.lisp"
            "questions/k06.lisp"
            "questions/k07.lisp"))

(defparameter *SOURCE-FILES*
    (mapcar (lambda (file-name)
        (merge-pathnames (format nil "~a~a" BASE-PATH file-name)))
        *FILE-NAMES*))

(dolist (file *SOURCE-FILES*) (load file))

(setf *random-state* (make-random-state t))

(k07:question-3 )