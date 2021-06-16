(ns hello-world.shared.question)

(defprotocol Question
  (question-1 [this])
  (question-2 [this])
  (question-3 [this])
  (question-4 [this]))