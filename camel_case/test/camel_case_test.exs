# defmodule CamelCaseTest do
#   use ExUnit.Case
#   doctest CamelCase

#   test "greets the world" do
#     assert CamelCase.hello() == :world
#   end
# end
defmodule TestCamelCase do
  use ExUnit.Case
  import CamelCase, only: [to_camel_case: 1]

  test "to_camel_case" do
    assert to_camel_case("the-stealth-warrior") == "theStealthWarrior"
    assert to_camel_case("The_Stealth_Warrior") == "TheStealthWarrior"
  end
end
