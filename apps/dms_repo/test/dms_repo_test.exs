defmodule DmsRepoTest do
  use ExUnit.Case
  doctest DmsRepo

  test "greets the world" do
    assert DmsRepo.hello() == :world
  end
end
