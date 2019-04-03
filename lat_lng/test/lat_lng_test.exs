defmodule LatLngTest do
  use ExUnit.Case

  @validCoordinates [
    "-23, 25",
    "4, -3"
    "24.53525235, 23.45235",
    "04, -23.234235",
    "43.91343345, 143"
  ]

  @invalidCoordinates [
    "23.234, - 23.4234",
    "2342.43536, 34.324236",
    "N23.43345, E32.6457",
    "99.234, 12.324",
    "6.325624, 43.34345.345",
    "0, 1,2",
    "0.342q0832, 1.2324",
    "23.245, 1e1"
  ]

  test "validate coordinates" do
    for value <- @validCoordinates do
      IO.inspect(LatLng.isValidCoordinates(value), label: value)
      assert LatLng.isValidCoordinates(value) == true
    end
  end

  test "invalidate coordinates" do
    for value <- @invalidCoordinates do
      IO.inspect(value, label: LatLng.isValidCoordinates(value))
      assert LatLng.isValidCoordinates(value) == false
    end
  end
end
