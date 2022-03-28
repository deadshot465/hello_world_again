(ns hello-world.assignments.musicians.musician
  [:require [clojure.core.async :as async]])

(defrecord Musician [name role skill-level channel])

(def first-names '("Valerie", "Arnold", "Carlos", "Dorothy", "Keesha", "Phoebe", "Ralphie", "Tim", "Wanda",
                    "Janet", "Leo", "Yuhei", "Carson"))

(def last-names '("Frizzle",
                   "Perlstein",
                   "Ramon",
                   "Ann",
                   "Franklin",
                   "Terese",
                   "Tennelli",
                   "Jamal",
                   "Li",
                   "Perlstein",
                   "Fujioka",
                   "Ito",
                   "Hage"))

(defn make-musician [role skill-level channel]
  (let [first-name (rand-nth first-names)
        last-name (rand-nth last-names)
        real-name (str first-name " " last-name)
        musician (->Musician real-name role skill-level channel)]
    (printf "Musician %s, playing the %s entered the room.\n" real-name role)
    (flush)
    musician))

(defn play-sound [musician]
  (let [is-fired (async/poll! (.-channel musician))]
    (if (not (= nil is-fired))
      (do (printf "%s just got back to playing in the subway.\n" (.-name musician))
          (flush)
          false)
      (case (.-skill_level musician)
        :good (do (printf "%s produced sound!\n" (.-name musician))
                  (flush)
                  true)
        :bad (let [failed (= 0 (rand-int 5))]
               (if (= true failed)
                 (do (printf "%s played a false note. Uh oh.\n" (.-name musician))
                     (printf "%s sucks! kicked that member out of the band!\n" (.-name musician))
                     (flush)
                     false)
                 (do (printf "%s produced sound!\n" (.-name musician))
                     (flush)
                     true)))
        true))))