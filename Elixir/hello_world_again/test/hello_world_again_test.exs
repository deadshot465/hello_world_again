defmodule HelloWorldAgainTest do
  use ExUnit.Case
  # doctest HelloWorldAgain

  test "test plus" do
    assert 5 == Rpn.rpn "2 3 +"
  end

  test "test minus" do
    assert 87 == Rpn.rpn("90 3 -")
  end

  test "test multiply" do
    assert -4 == Rpn.rpn("10 4 3 + 2 * -")
  end

  test "test divide" do
    assert -2 == Rpn.rpn("10 4 3 + 2 * - 2 /")
  end

  test "test bad input" do
    assert_raise(MatchError, fn -> Rpn.rpn("90 34 12 33 55 66 + * - +") end)
  end

  test "test complex input" do
    assert 4037 == Rpn.rpn("90 34 12 33 55 66 + * - + -")
  end

  test "test power" do
    assert 8 == Rpn.rpn("2 3 ^")
  end

  test "test sqrt" do
    assert :math.sqrt(2.0) == Rpn.rpn("2 0.5 ^")
  end

  test "test ln" do
    assert :math.log(2.7) == Rpn.rpn("2.7 ln")
  end

  test "test log10" do
    assert :math.log10(2.7) == Rpn.rpn("2.7 log10")
  end

  test "test sum" do
    assert 50 == Rpn.rpn("10 10 10 20 sum")
  end

  test "test sum and divide" do
    assert 10 == Rpn.rpn("10 10 10 20 sum 5 /")
  end

  test "test product" do
    assert 1000 == Rpn.rpn("10 10 20 0.5 prod")
  end
end
