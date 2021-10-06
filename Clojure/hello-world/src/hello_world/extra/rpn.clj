(ns hello-world.extra.rpn
  (:require [clojure.string :as str]))

(defn read-float [n]
  (Float/parseFloat n))

(defn inner-rpn [coll operator]
  (case operator
    "+" (do (let [[x y & xs] coll]
              (cons (+ y x) xs)))
    "-" (do (let [[x y & xs] coll]
              (cons (- y x) xs)))
    "*" (do (let [[x y & xs] coll]
              (cons (* y x) xs)))
    "/" (do (let [[x y & xs] coll]
              (cons (/ y x) xs)))
    "^" (do (let [[x y & xs] coll]
              (cons (Math/pow y x) xs)))
    "ln" (do (let [[x & xs] coll]
               (cons (Math/log x) xs)))
    "log10" (do (let [[x & xs] coll]
                  (cons (Math/log10 x) xs)))
    "sum" (seq (list (reduce + coll)))
    "prod" (seq (list (reduce * coll)))
    (cons (read-float operator) coll)))

(defn rpn [s]
  (if (not (string? s)) (throw (Exception. "The input should be a string."))
                        (let [result (reduce inner-rpn (seq []) (str/split s #" "))]
                          (if (> (count result) 1) (throw (Exception. "Bad input."))
                                                   (last result)))))
