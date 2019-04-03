defmodule Test do
  defstruct [:value, :result]

  def simpleTests do
    [
      %Test{value: " 0", result: false},
      %Test{value: "abc", result: false},
      %Test{value: "000", result: true},
      %Test{value: "110", result: true},
      %Test{value: "111", result: false},
      %Test{value: Integer.to_string(12_345_678, 2), result: true}
    ]
  end
end

defmodule BinaryMultipleTest do
  use ExUnit.Case

  test "some basic tests" do
    Enum.each(Test.simpleTests(), fn t ->
      IO.puts("testing \"" <> t.value <> "\"")
      assert Regex.match?(BinaryMultiple.multipleOf3Regex(), t.value) == t.result
    end)
  end
end
