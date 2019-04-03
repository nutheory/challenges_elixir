defmodule IntegerDepth do
  def compute_depth(n) do
    Stream.iterate(1, &(&1 + 1))
    |> Enum.reduce_while([], fn count, acc ->
      acc =
        Integer.digits(n * count)
        |> Enum.filter(fn num -> !Enum.member?(acc, num) end)
        |> Enum.uniq()
        |> Enum.concat(acc)

      if length(acc) === 10, do: {:halt, count}, else: {:cont, acc}
    end)
  end
end
