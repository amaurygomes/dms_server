defmodule DmsCoreTest do
  use ExUnit.Case
  doctest DmsCore

  test "greets the world" do
    assert DmsCore.hello() == :world
  end
end
