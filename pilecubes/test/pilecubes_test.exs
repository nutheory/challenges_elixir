defmodule PilecubesTest do
  use ExUnit.Case

  def testFindNb(numtest, m, ans) do
    IO.puts("Test #{numtest}")
    assert Pilecubes.find_nb(m) == ans
  end

  test "find_nb" do
    testFindNb(1, 1_071_225, 45)
    testFindNb(1, 4_183_059_834_009, 2022)
    testFindNb(2, 24_723_578_342_962, -1)
    testFindNb(3, 135_440_716_410_000, 4824)
    testFindNb(4, 40_539_911_473_216, 3568)
  end
end
