defmodule HighestScoringWord do
  def high(str) do
    alpha_map = %{
      a: 1,
      b: 2,
      c: 3,
      d: 4,
      e: 5,
      f: 6,
      g: 7,
      h: 8,
      i: 9,
      j: 10,
      k: 11,
      l: 12,
      m: 13,
      n: 14,
      o: 15,
      p: 16,
      q: 17,
      r: 18,
      s: 19,
      t: 20,
      u: 21,
      v: 22,
      w: 23,
      x: 24,
      y: 25,
      z: 26
    }

    str
    |> String.split(" ")
    |> Enum.map(fn word ->
      count =
        word
        |> String.graphemes()
        |> Enum.map(fn letter ->
          alpha_map[String.to_atom(letter)]
        end)
        |> Enum.sum()

      [count, word]
    end)
    |> Enum.sort(&(hd(&1) >= hd(&2)))
    |> List.first()
    |> List.last()
  end
end
