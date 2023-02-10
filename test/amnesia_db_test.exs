defmodule AmnesiaDbTest do
  use ExUnit.Case
  doctest AmnesiaDb

  test "greets the world" do
    assert AmnesiaDb.hello() == :world
  end
end
