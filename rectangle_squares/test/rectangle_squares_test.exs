defmodule RectangleSquaresTest do
  use ExUnit.Case

  defp testequal(numtest, l, w, ans) do
    IO.puts("Test #{numtest}")
    assert RectangleSquares.squares_in_rect(l, w) == ans
  end

  test "squares_in_rect" do
    testequal(1, 5, 5, nil)
    testequal(2, 5, 3, [3, 2, 1, 1])
    testequal(4, 20, 14, [14, 6, 6, 2, 2, 2])
  end
end
