import ArabicToRoman, only: [solution: 1]

defmodule TestArabicToRoman do
  use ExUnit.Case

  test "converts from arabic to roman" do
    Enum.each(
      [
        {1, "I"},
        {2, "II"},
        {3, "III"},
        {4, "IV"},
        {5, "V"},
        {6, "VI"},
        {7, "VII"},
        {8, "VIII"},
        {9, "IX"},
        {10, "X"},
        {11, "XI"},
        {12, "XII"},
        {13, "XIII"},
        {14, "XIV"},
        {15, "XV"},
        {16, "XVI"},
        {19, "XIX"},
        {20, "XX"},
        {21, "XXI"},
        {40, "XL"},
        {49, "XLIX"},
        {50, "L"},
        {90, "XC"},
        {99, "XCIX"},
        {100, "C"},
        {101, "CI"},
        {144, "CXLIV"},
        {470, "CDLXX"},
        {578, "DLXXVIII"},
        {500, "D"},
        {501, "DI"},
        {1000, "M"},
        {1001, "MI"},
        {1002, "MII"},
        {2000, "MM"},
        {1111, "MCXI"},
        {1666, "MDCLXVI"},
        {1673, "MDCLXXIII"},
        {1990, "MCMXC"}
      ],
      fn {number, expected} ->
        assert solution(number) == expected
      end
    )
  end
end
