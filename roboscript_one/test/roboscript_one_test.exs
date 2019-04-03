defmodule RoboscriptOneTest do
  use ExUnit.Case
  import RoboscriptOne, only: [highlight: 1]

  def solution(code) do
    String.replace(code, ~r/(F+)/, "<span style=\"color: pink\">\\0</span>")
    |> String.replace(~r/(L+)/, "<span style=\"color: red\">\\0</span>")
    |> String.replace(~r/(R+)/, "<span style=\"color: green\">\\0</span>")
    |> String.replace(~r/(\d+)/, "<span style=\"color: orange\">\\0</span>")
  end

  def randomCode() do
    Enum.take_random(
      String.split(
        "FRL0123456789()FRL0123456789()FRL0123456789()FRL0123456789()FFFFFFFLLLLLLRRRRRR",
        ""
      ),
      10 + trunc(Float.floor(:rand.uniform() * 91))
    )
    |> Enum.join("")
  end

  test "Your Syntax Highlighter" do
    IO.puts("Code without syntax highlighting: F3RF5LF7")
    IO.inspect(highlight("F3RF5LF7"), label: "Your code with syntax highlighting: ")

    IO.puts(
      "Expected syntax highlighting: <span style=\"color: pink\">F</span><span style=\"color: orange\">3</span><span style=\"color: green\">R</span><span style=\"color: pink\">F</span><span style=\"color: orange\">5</span><span style=\"color: red\">L</span><span style=\"color: pink\">F</span><span style=\"color: orange\">7</span>"
    )

    assert highlight("F3RF5LF7") ==
             "<span style=\"color: pink\">F</span><span style=\"color: orange\">3</span><span style=\"color: green\">R</span><span style=\"color: pink\">F</span><span style=\"color: orange\">5</span><span style=\"color: red\">L</span><span style=\"color: pink\">F</span><span style=\"color: orange\">7</span>"

    IO.puts("Code without syntax highlighting: FFFR345F2LL")
    IO.inspect(highlight("FFFR345F2LL"), label: "Your code with syntax highlighting: ")

    IO.puts(
      "Expected syntax highlighting: <span style=\"color: pink\">FFF</span><span style=\"color: green\">R</span><span style=\"color: orange\">345</span><span style=\"color: pink\">F</span><span style=\"color: orange\">2</span><span style=\"color: red\">LL</span>"
    )

    assert highlight("FFFR345F2LL") ==
             "<span style=\"color: pink\">FFF</span><span style=\"color: green\">R</span><span style=\"color: orange\">345</span><span style=\"color: pink\">F</span><span style=\"color: orange\">2</span><span style=\"color: red\">LL</span>"
  end

  test "should work for some fixed tests" do
    assert highlight("RRRRRF45L3F2") ==
             "<span style=\"color: green\">RRRRR</span><span style=\"color: pink\">F</span><span style=\"color: orange\">45</span><span style=\"color: red\">L</span><span style=\"color: orange\">3</span><span style=\"color: pink\">F</span><span style=\"color: orange\">2</span>"

    assert highlight("RRRRR(F45L3)F2") ==
             "<span style=\"color: green\">RRRRR</span>(<span style=\"color: pink\">F</span><span style=\"color: orange\">45</span><span style=\"color: red\">L</span><span style=\"color: orange\">3</span>)<span style=\"color: pink\">F</span><span style=\"color: orange\">2</span>"

    assert highlight("FF(LF6(RF3)2)3") ==
             "<span style=\"color: pink\">FF</span>(<span style=\"color: red\">L</span><span style=\"color: pink\">F</span><span style=\"color: orange\">6</span>(<span style=\"color: green\">R</span><span style=\"color: pink\">F</span><span style=\"color: orange\">3</span>)<span style=\"color: orange\">2</span>)<span style=\"color: orange\">3</span>"
  end

  test "should work for random test cases" do
    Enum.each(1..10, fn _ ->
      input = randomCode()
      expected = solution(input)
      actual = highlight(input)
      assert(actual) == expected
    end)
  end
end
