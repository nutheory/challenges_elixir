# With a little help from my local elixir community it was pointed out that
# floats have poor precision and just like you say if I manage with Integer
# all the way it worked. I just had to "hack" ceiling operator :)

defmodule SomeEgyptianFraction do
  require Integer

  defp half_even(int1, int2, even) do
    num = int1 / int2 * 100
    int = Float.floor(num)
    dec = num - int

    if dec === 0.5 do
      new_even = even + 1
      if Integer.is_even(new_even), do: {int + 1, new_even}, else: {int, new_even}
    else
      round(num)
    end
  end

  defp half_even(int1) do
    num = int1 * 100
    int = Float.floor(num)
    dec = num - int

    if dec === 0.5 do
      @even = @even + 1
      if Integer.is_even(@even), do: int + 1, else: int
    else
      round(num)
    end
  end

  def decompose(current, target, _, list) when current === target do
    # IO.inspect(list |> Enum.reverse(), label: "OUT")
    list |> Enum.reverse()
  end

  def decompose(current, target, count, list) when current + round(1 / count * 100) <= target do
    head = if current + 1 === count, do: Integer.to_string(count), else: "1/#{count}"
    # IO.inspect(@even, label: "LESS #{count}")
    # IO.inspect(current + 1 / count * 100, label: "LESS #{count}")
    # IO.inspect(current + half_even(1, count), label: "LESS #{count}")
    decompose(current + half_even(1, count), target, 2, [head | list])
  end

  def decompose(current, target, count, list) do
    # IO.inspect(current, label: "Default #{count}")
    decompose(current, target, count + 1, list)
  end

  def decompose(n) do
    IO.inspect(n, label: "IN")

    cond do
      String.contains?(n, ".") ->
        decompose(0, half_even(String.to_integer(n)), 1, [])

      String.contains?(n, "/") ->
        nums = String.split(n, "/")
        decon = [String.to_integer(hd(nums)), String.to_integer(tl(nums) |> List.first())]

        if hd(decon) >= List.first(tl(decon)) do
          # divd = hd(decon) / List.first(tl(decon))
          rem = rem(hd(decon), List.first(tl(decon)))
          whole = [div(hd(decon), List.first(tl(decon))) |> Integer.to_string()]
          # IO.inspect(divd, label: rem)
          if rem === 0 do
            [div(hd(decon), List.first(tl(decon))) |> Integer.to_string()]
          else
            decompose(0, half_even(rem, List.first(tl(decon))), 2, whole)
          end
        else
          # IO.inspect(trunc(hd(decon) / List.first(tl(decon)) * 100), label: "LOOP")
          decompose(, half_even(hd(decon), List.first(tl(decon))), 1, [])
        end

      true ->
        []
    end
  end
end
