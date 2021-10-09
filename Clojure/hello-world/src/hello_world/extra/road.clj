(ns hello-world.extra.road
  (:require [clojure.string :as str]))

(defrecord Route [destination path]
  Comparable
  (compareTo [_ other]
    (cond
      (> destination (:destination other)) -1
      (< destination (:destination other)) 1
      :else 0)))

(defrecord RoutingResult [a b])

(defn parse-map [text]
  (->> (str/split-lines text)
       (map str/trim)
       (map #(Integer/parseInt %))
       (apply list)))

(defn group-values [c]
  (loop [coll c
         acc '()]
    (if (empty? coll) (reverse acc)
                      (let [[a b x & xs] coll]
                        (recur xs (cons [a b x] acc))))))

(defn shortest-steps [acc elem]
  (let [[a b x] elem
        route-a (:a acc)
        route-b (:b acc)]
    (let [dist-a (:destination route-a)
          path-a (:path route-a)
          dist-b (:destination route-b)
          path-b (:path route-b)]
      (let [opt-a1 (->Route (+ dist-a a) (cons [:a a] path-a))
            opt-a2 (->Route (+ (+ dist-b b) x) (cons [:x x] (cons [:b b] path-b)))
            opt-b1 (->Route (+ dist-b b) (cons [:b b] path-b))
            opt-b2 (->Route (+ (+ dist-a a) x) (cons [:x x] (cons [:a a] path-a)))]
        (->RoutingResult (if (< 0 (compare opt-a1 opt-a2)) opt-a1 opt-a2) (if (< 0 (compare opt-b1 opt-b2)) opt-b1 opt-b2))))))

(defn optimal-path [values]
  (let [initial-result (->RoutingResult (->Route 0 '()) (->Route 0 '()))]
    (let [routing-result (reduce shortest-steps initial-result values)]
      (let [a (:a routing-result)
            b (:b routing-result)]
        (let [final-result (cond
                             (not (= (first (:path a)) [:x 0])) a
                             (not (= (first (:path b)) [:x 0])) b
                             :else (->Route 0 '()))]
          (reverse (:path final-result)))))))

(defn run []
  (->> (slurp "road.txt")
       (parse-map)
       (group-values)
       (optimal-path)))