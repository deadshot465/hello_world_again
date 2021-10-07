module Test.Main where

import Prelude

import Data.Either (Either(..))
import Effect (Effect)
import Extra.Rpn (log10, rpn)
import Math (log, sqrt)
import Test.Unit (suite, test)
import Test.Unit.Assert as Assert
import Test.Unit.Main (runTest)

main :: Effect Unit
main = do
  runTest do
    suite "Test Plus" do
      test "Test Plus" do
        Assert.equal (Right 5.0) (rpn "2 3 +")
    suite "Test Minus" do
      test "Test Minus" do
        Assert.equal (Right 87.0) (rpn "90 3 -")
    suite "Test Multiply" do
      test "Test Multiply" do
        Assert.equal (Right (-4.0)) (rpn "10 4 3 + 2 * -")
    suite "Test Divide" do
      test "Test Divide" do
        Assert.equal (Right (-2.0)) (rpn "10 4 3 + 2 * - 2 /")
    suite "Test Bad Input" do
      test "Test Bad Input" do
        Assert.equal (Left "Bad Input") (rpn "90 34 12 33 55 66 + * - +")
    suite "Test Complex Input" do
      test "Test Complex Input" do
        Assert.equal (Right 4037.0) (rpn "90 34 12 33 55 66 + * - + -")
    suite "Test Power" do
      test "Test Power" do
        Assert.equal (Right 8.0) (rpn "2 3 ^")
    suite "Test Sqrt" do
      test "Test Sqrt" do
        Assert.equal (Right $ sqrt 2.0) (rpn "2 0.5 ^")
    suite "Test Ln" do
      test "Test Ln" do
        Assert.equal (Right $ log 2.7) (rpn "2.7 ln")
    suite "Test Log10" do
      test "Test Log10" do
        Assert.equal (Right $ log10 2.7) (rpn "2.7 log10")
    suite "Test Sum" do
      test "Test Sum" do
        Assert.equal (Right 50.0) (rpn "10 10 10 20 sum")
    suite "Test Sum And Divide" do
      test "Test Sum And Divide" do
        Assert.equal (Right 10.0) (rpn "10 10 10 20 sum 5 /")
    suite "Test Product" do
      test "Test Product" do
        Assert.equal (Right 1000.0) (rpn "10 10 20 0.5 prod")