# n = 12; decomp(12) -> "2^10 * 3^5 * 5^2 * 7 * 11"
# since 12! is divisible by 2 ten times, by 3 five times, by 5 two times and by 7 and 11 only once.
# 2 3 2 2 5 3 2 7 2 2 2 3 3 2 5 11 3 2 2
# 2^10 * 3^5 * 5^2 * 7 * 11

defmodule FactorialDecomposition do
  def prime_factors(dict, num, next \\ 2)

  def prime_factors(dict, num, 2) do
    cond do
      rem(num, 2) == 0 ->
        if Map.has_key?(dict, 2) do
          Map.get_and_update(dict, 2, fn val -> {val, val + 1} end)
          |> elem(1)
          |> prime_factors(div(num, 2))
        else
          Map.put(dict, 2, 1)
        end

      4 > num ->
        if Map.has_key?(dict, num) do
          Map.get_and_update(dict, num, fn val -> {val, val + 1} end)
          |> elem(1)
        else
          Map.put(dict, num, 1)
        end

      true ->
        prime_factors(dict, num, 3)
    end
  end

  def prime_factors(dict, num, next) do
    cond do
      rem(num, next) == 0 ->
        if Map.has_key?(dict, next) do
          Map.get_and_update(dict, next, fn val -> {val, val + 1} end)
          |> elem(1)
          |> prime_factors(div(num, next))
        else
          Map.put(dict, next, 1)
        end

      next + next > num ->
        if Map.has_key?(dict, num) do
          Map.get_and_update(dict, num, fn val -> {val, val + 1} end)
          |> elem(1)
        else
          Map.put(dict, num, 1)
        end

      true ->
        prime_factors(dict, num, next + 2)
    end
  end

  def decomp(n) do
    nums =
      Enum.reduce(2..n, %{}, fn x, acc ->
        prime_factors(acc, x)
      end)
      |> Map.delete(1)
      |> Enum.sort()
      |> Enum.reduce("", fn {k, v}, acc ->
        if v === 1 do
          acc <> "#{k} * "
        else
          acc <> "#{k}^#{v} * "
        end
      end)
      |> String.replace_trailing(" * ", "")
  end
end
