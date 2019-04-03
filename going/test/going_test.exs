defmodule GoingTest do
  use ExUnit.Case
  doctest Going

  def assertFuzzy(n, exp) do
    merr = 1.0e-6
    IO.puts("Testing n: #{n}")
    act = Going.going(n)
    IO.puts("act: #{act}")
    IO.puts("exp: #{exp}")
    inrange = abs(act - exp) <= merr

    if inrange == false do
      IO.puts("At 1e-6: Expected value must be #{exp} but was #{act}")
    end

    assert inrange == true
    IO.puts("#")
  end

  test "going" do
    assertFuzzy(5, 1.275)
    assertFuzzy(6, 1.2125)
    assertFuzzy(7, 1.173214)
  end
end
