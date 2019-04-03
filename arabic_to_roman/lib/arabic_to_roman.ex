defmodule ArabicToRoman do
  def solution(number) do
    build_numeral("", number)
  end

  defp build_numeral(numeral, number) when number === 0, do: numeral

  defp build_numeral(numeral, number) do
    cond do
      number >= 1000 -> build_numeral(numeral <> "M", number - 1000)
      number >= 900 -> build_numeral(numeral <> "CM", number - 900)
      number >= 500 -> build_numeral(numeral <> "D", number - 500)
      number >= 400 -> build_numeral(numeral <> "CD", number - 400)
      number >= 100 -> build_numeral(numeral <> "C", number - 100)
      number >= 90 -> build_numeral(numeral <> "XC", number - 90)
      number >= 50 -> build_numeral(numeral <> "L", number - 50)
      number >= 40 -> build_numeral(numeral <> "XL", number - 40)
      number >= 10 -> build_numeral(numeral <> "X", number - 10)
      number >= 9 -> build_numeral(numeral <> "IX", number - 9)
      number >= 5 -> build_numeral(numeral <> "V", number - 5)
      number >= 4 -> build_numeral(numeral <> "IV", number - 4)
      number >= 1 -> build_numeral(numeral <> "I", number - 1)
    end
  end
end
