defmodule JosephusTest do
  use ExUnit.Case

  # TODO: Replace examples and use TDD development by writing your own tests
  test "some test description" do
    assert Josephus.survivor(7, 3) == 4
    assert Josephus.survivor(11, 19) == 10
    assert Josephus.survivor(1, 300) == 1
    assert Josephus.survivor(14, 2) == 13
    assert Josephus.survivor(100, 1) == 100
    assert Josephus.survivor(5000, 30001) == 2639
  end
end
