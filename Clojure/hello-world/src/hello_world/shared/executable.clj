(ns hello-world.shared.executable)

(defprotocol Execute
  (execute [this number]))

(deftype Executable [question]
  Execute
  (execute [_ number]
    (cond (= number 1) (.question-1 question)
          (= number 2) (.question-2 question)
          (= number 3) (.question-3 question)
          (= number 4) (.question-4 question)
          :else ())))