defmodule LatLng do
  def isValidCoordinates(coordinates) do
    coordinates
    |> String.split(", ")
    |> validate_format()
    |> validate_range()
    |> case do
      {:ok, _} -> true
      {:error, _} -> false
    end
  end

  defp validate_format(coords) do
    coords
    |> Enum.map(fn coord -> String.match?(coord, ~r/(^-?\d{0,3})\.?\d+?$/) end)
    |> Enum.member?(false)
    |> case do
      true -> {:error, "not valid"}
      false -> {:ok, coords}
    end
  end

  defp validate_range({:ok, coords}) do
    coords
    |> Enum.reduce([], fn coord, acc ->
      if length(acc) === 0 do
        [range_to_num(coord) |> (&(&1 in 0..90)).() | acc]
      else
        [range_to_num(coord) |> (&(&1 in 0..180)).() | acc]
      end
    end)
    |> Enum.member?(false)
    |> case do
      true -> {:error, "not valid"}
      false -> {:ok, coords}
    end
  end

  defp validate_range({_, _}), do: {:error, ""}

  defp range_to_num(coord) do
    coord
    |> String.split(".")
    |> List.first()
    |> String.replace("-", "")
    |> String.to_integer()
  end
end
