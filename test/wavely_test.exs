defmodule WavelyTest do
  use ExUnit.Case
  doctest Wavely

  test "greets the world" do
    assert Wavely.hello() == :world
  end
end
