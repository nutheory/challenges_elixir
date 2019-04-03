defmodule Whicharein do
  def in_array(array1, array2) do
    array1
    |> Enum.reduce([], fn arr_outer, acc ->
      # IO.inspect(arr_outer)
      array2
      |> Enum.map(fn arr_inner ->
        IO.inspect(arr_inner, label: arr_outer)
        if String.contains?(arr_inner, arr_outer), do: List.insert_at(acc, 0, arr_outer)
      end)
    end)
    |> IO.inspect()
    |> List.flatten()
    |> Enum.uniq()
    |> Enum.sort()
    |> List.delete(nil)
  end
end
