defmodule TestIntegerDepth do
  use ExUnit.Case
  import IntegerDepth

  test "Example test 1" do
    assert compute_depth(1) == 10
  end

  test "Example test 2" do
    assert compute_depth(42) == 9
  end

  test "Example test 3" do
    assert compute_depth(25) == 36
  end
end
