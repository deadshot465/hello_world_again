defmodule HelloWorldAgainTest do
  use ExUnit.Case
  doctest HelloWorldAgain

  test "greets the world" do
    assert HelloWorldAgain.hello() == :world
  end
end
