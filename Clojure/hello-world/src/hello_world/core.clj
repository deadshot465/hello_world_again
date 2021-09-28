(ns hello-world.core
  (:require [hello-world.shared.executable :refer :all]
            [hello-world.assignments.question-1 :refer :all]
            [hello-world.assignments.question-2 :refer :all]
            [hello-world.assignments.question-3 :refer :all]
            [hello-world.assignments.question-4 :refer :all]
            [hello-world.assignments.question-5 :refer :all]
            [hello-world.assignments.question-6 :refer :all]
            [hello-world.assignments.question-7 :refer :all]
            [hello-world.assignments.question-8 :refer :all])
  (:gen-class))

(defn show-selections [chapter]
  (->> (map (fn [x] (str "\t" x  ") " (if (< chapter 10) "K0" "K") chapter "_" x)) '(1 2 3 4))
       (clojure.string/join)
       (println)))

(def executables (list (->Executable (->K01)) (->Executable (->K02)) (->Executable (->K03))
                       (->Executable (->K04)) (->Executable (->K05)) (->Executable (->K06))
                       (->Executable (->K07)) (->Executable (->K08))))

(defn -main [& _]
  (println "実行したいプログラムを選択してください。")
  (->> (map-indexed (fn [index _]
                 (str (+ index 1) ") " (if (< index 10) "K0" "K") (+ index 1) "\t\t")) executables)
       (clojure.string/join)
       (println))
  (newline)
  (let [choice (-> (read-line)
                   (Integer/parseInt))]
    (show-selections choice)
    (let [choice-2 (-> (read-line)
                       (Integer/parseInt))]
      (execute (nth executables (- choice 1)) choice-2))))