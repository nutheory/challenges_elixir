defmodule TribonacciSequence do
  def tribonacci(_, stop_at, count, list) when count === stop_at do
    list |> Enum.reverse()
  end

  def tribonacci(signature, stop_at, count, list) do
    new_list =
      cond do
        length(list) <= 2 ->
          [elem(signature, count) | list]

        true ->
          [hd(list) + Enum.at(list, 1) + Enum.at(list, 2) | list]
      end

    tribonacci(signature, stop_at, count + 1, new_list)
  end

  @spec tribonacci({number, number, number}, non_neg_integer) :: [number]
  def tribonacci(signature, n) do
    tribonacci(signature, n, 0, [])
  end
end
