(ns hello-world.core-test
  (:require [clojure.test :refer :all]
            [hello-world.core :refer :all]
            [hello-world.extra.rpn :as rpn :only rpn]))

(deftest addition
  (testing "Test Plus."
    (is (= 5.0 (rpn/rpn "2 3 +")))))

(deftest deduction
  (testing "Test Minus."
    (is (= 87.0 (rpn/rpn "90 3 -")))))

(deftest multiplication
  (testing "Test Multiply."
    (is (= -4.0 (rpn/rpn "10 4 3 + 2 * -")))))

(deftest division
  (testing "Test Divide."
    (is (= -2.0 (rpn/rpn "10 4 3 + 2 * - 2 /")))))

(deftest bad-input
  (testing "Test Bad Input."
    (is (thrown? Exception (rpn/rpn "90 34 12 33 55 66 + * - +")))))

(deftest complex-input-1
  (testing "Test Complex Input 1"
    (is (= 4037.0 (rpn/rpn "90 34 12 33 55 66 + * - + -")))))

(deftest pow
  (testing "Test Power"
    (is (= 8.0 (rpn/rpn "2 3 ^")))))

(deftest sqrt
  (testing "Test Square Root"
    (is (= (Math/sqrt 2.0) (rpn/rpn "2 0.5 ^")))))

(deftest log-n
  (testing "Test Ln"
    (let [result-1 (Math/log 2.7)
          result-2 (rpn/rpn "2.7 ln")]
      (is (= 0 (Float/compare result-1 result-2))))))

(deftest log-10
  (testing "Test Log10"
    (let [result-1 (Math/log10 2.7)
          result-2 (rpn/rpn "2.7 log10")]
      (is (= 0 (Float/compare result-1 result-2))))))

(deftest sum
  (testing "Test Sum"
    (is (= 50.0 (rpn/rpn "10 10 10 20 sum")))))

(deftest sum-and-divide
  (testing "Test Sum and Divide"
    (is (= 10.0 (rpn/rpn "10 10 10 20 sum 5 /")))))

(deftest product
  (testing "Test Product"
    (is (= 1000.0 (rpn/rpn "10 10 20 0.5 prod")))))

(run-tests)
