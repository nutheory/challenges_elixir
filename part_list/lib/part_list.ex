defmodule PartList do
  def part_list(a) do
    create_list(a, [], 1, length(a))
  end

  def create_list(_, new_list, count, total) when count === total, do: Enum.reverse(new_list)

  def create_list(list, mod_list, count, total) do
    new_list =
      list
      |> Enum.split(count)
      |> Tuple.to_list()
      |> Enum.map(fn words -> Enum.join(words, " ") end)

    create_list(list, [new_list | mod_list], count + 1, total)
  end
end
