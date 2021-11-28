(defpackage :golem
    (:use :cl)
    (:export #:make-golem #:golem-hp #:golem-defense #:golem-attack))

(in-package :golem)

(defstruct golem
    hp defense attack)