(in-package :asdf-user)

(defsystem "CommonLisp"
    :class :package-inferred-system
    :depends-on ("CommonLisp/src/app")
    :description ""
    :in-order-to ((test-op (load-op "CommonLisp/test/all")))
    :perform (test-op (o c) (symbol-call :test/all :test-suite))
)

(defsystem "CommonLisp/test"
    :depends-on ("CommonLisp/test/all")
)

(register-system-packages "CommonLisp/src/app" '(:app))
(register-system-packages "CommonLisp/test/all" '(:test/all))
