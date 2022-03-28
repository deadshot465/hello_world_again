(ns hello-world.assignments.musicians.band-supervisor
  [:require [hello-world.assignments.musicians.musician :as musician]
            [clojure.core.async :as async]])

(def delay 750)

(defn add-band-member [role skill-level channel]
  (let [fire-channel (async/chan 10)
        new-musician (musician/make-musician role skill-level fire-channel)]
    (async/go-loop [m new-musician
                    r role
                    s skill-level
                    c channel]
      (async/<! (async/timeout delay))
      (let [play-result (musician/play-sound m)]
        (if (= true play-result)
          (recur m r s c)
          (async/>! c {:role r :skill-level s}))))
    fire-channel))

(defn start-band [max-retries]
  (let [channel (async/chan 10)
        members (hash-map :singer (add-band-member :singer :good channel)
                          :bass (add-band-member :bass :good channel)
                          :drum (add-band-member :drum :bad channel)
                          :guitar (add-band-member :guitar :good channel))]
    (loop [c channel
           ms members
           retries max-retries]
      (let [new-data (async/<!! c)]
        (if (<= retries 0)
          (do (println "The manager is mad and fired the whole band!")
              (run! (fn [[_ value]] (async/>!! value 0)) ms)
              (async/<!! (async/timeout 3000)))
          (let [new-member (add-band-member (:role new-data) (:skill-level new-data) c)
                new-members (assoc (dissoc ms (:role new-data)) (:role new-data) new-member)]
            (recur c new-members (- retries 1))))))))
