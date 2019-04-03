# defmodule FourSkyscrapers do
#   def solve(clues) do
#     grid_total = length(clues)
#     grid_size = round(:math.sqrt(grid_total))

#     %{0 => [], y: []}
#     |> setup_grid(clues, :x, grid_total - 1, 4, grid_size, 1)
#     |> setup_grid(clues, :y, grid_total - 5, 0, grid_size, 1)
#     |> init_skyscrapers()
#     |> IO.inspect()
#     |> setup_intersections()

#     # |> merge_x_y(grid_size)
#   end

#   def setup_grid(grid, _, axis, _, _, grid_size, count) when count > grid_size,
#     do: Map.get_and_update(grid, axis, fn s -> {:ok, Enum.reverse(s)} end) |> elem(1)

#   def setup_grid(grid, clues, axis, f_idx, l_idx, grid_size, count) do
#     new_grid =
#       Map.get_and_update!(grid, axis, fn x ->
#         left = Enum.at(clues, (axis === :x && f_idx) || l_idx)
#         right = Enum.at(clues, (axis === :x && l_idx) || f_idx)
#         {:ok, [%{clues: {left, right}, values: [0, 0, 0, 0]} | x]}
#       end)

#     setup_grid(elem(new_grid, 1), clues, axis, f_idx - 1, l_idx + 1, grid_size, count + 1)
#   end

#   def init_skyscrapers(grid) do
#     Enum.map(grid, fn {k, v} ->
#       {k,
#        Enum.map(v, fn line ->
#          init_nums(line)
#        end)}
#     end)
#     |> Enum.into(%{})
#   end

#   # def find_anomalies(columns) do
#   #   IO.inspect(columns, label: "find_anomalies")
#   # end

#   # def merge_x_y(grid, grid_size) do
#   #   IO.inspect(grid, label: "merge_x_y")

#   # 0..(grid_size - 1)
#   # |> Enum.map(fn idx ->
#   #   Enum.map(grid[:x], fn x -> Enum.at(x[:values], idx) end)
#   #   |> find_anomalies()

#   # |> Enum.map(&Enum.uniq(List.flatten(elem(&1, 1))))
#   # |> Enum.reduce(fn x, acc ->
#   #   Enum.max_by(length(x), length(acc))
#   # end)
#   # Enum.find_index(fn x -> Enum.max_by(length(x)) end)
#   # |> IO.inspect()

#   # |> Enum.sort_by(fn a -> length(a) end)
#   # |> Enum.reduce(fn x, acc ->
#   #   IO.inspect(x, label: "X")
#   #   IO.inspect(acc, label: "ACC")
#   #   [acc -- x | acc]
#   # end)
#   # |> IO.inspect()
#   # end)

#   # 0..(grid_size - 1)
#   # |> Enum.map(fn n ->
#   # Map.get(grid, :x)
#   # |> Enum.reduce([], fn x, acc ->
#   #   IO.inspect(x, label: "XXX")
#   #   [x[:values] | acc]
#   # end)
#   # |> Enum.reverse()

#   # end)
#   # |> Enum.with_index()
#   # |> Enum.reduce([], fn {merge_y, idx}, acc ->
#   #   [
#   #     Enum.zip(Enum.at(Map.get(grid, :x), idx)[:values], merge_y)
#   #     |> Enum.reduce([], fn {x, y}, acc ->
#   #       if is_list(x), do: [y | acc], else: [x | acc]
#   #     end)
#   #     |> Enum.reverse()
#   #     | acc
#   #   ]
#   # end)
#   # |> Enum.reverse()
#   # end

#   # def refactor_nums(grid) do
#   #   IO.inspect(grid, label: "GRID")

#   # end

#   def setup_intersections(hey) do
#     nil
#   end

#   def intersections(hey) do
#     nil
#   end

#   def init_nums(%{clues: {4, _}, values: _}), do: %{clues: {4, 1}, values: [1, 2, 3, 4]}
#   def init_nums(%{clues: {_, 4}, values: _}), do: %{clues: {1, 4}, values: [4, 3, 2, 1]}
#   def init_nums(%{clues: {1, 2}, values: _}), do: %{clues: {1, 2}, values: [4, [1, 2], [1, 2], 3]}
#   def init_nums(%{clues: {2, 1}, values: _}), do: %{clues: {2, 1}, values: [3, [1, 2], [1, 2], 4]}

#   def init_nums(%{clues: {2, 3}, values: _}),
#     do: %{clues: {2, 3}, values: [[1, 2, 3], 4, [2, 3], [1, 2]]}

#   def init_nums(%{clues: {1, 3}, values: _}),
#     do: %{clues: {1, 3}, values: [4, [1, 2, 3], [1, 2, 3], [1, 2]]}

#   def init_nums(%{clues: {3, 1}, values: _}),
#     do: %{clues: {3, 1}, values: [[1, 2], [1, 2, 3], [1, 2, 3], 4]}

#   def init_nums(%{clues: {3, 2}, values: _}),
#     do: %{clues: {3, 2}, values: [[1, 2], [1, 2, 3], 4, [1, 2, 3]]}

#   def init_nums(%{clues: {2, 2}, values: _}),
#     do: %{clues: {2, 2}, values: [[1, 2, 3], [1, 2, 3, 4], [1, 2, 3, 4], [1, 2, 3]]}

#   def init_nums(%{clues: {f, l}, values: v}), do: %{clues: {f, l}, values: v}
# end

defmodule Grid do
  defstruct [:row, :col]
end

defmodule FourSkyscrapers do
  def solve(clues) do
    grid_total = length(clues)
    grid_size = round(:math.sqrt(grid_total))

    build_grid(clues, grid_size)
  end

  def build_grid(clues, grid_size) do
    for r <- 1..grid_size,
        c <- 1..grid_size,
        into: MapSet.new(),
        do: %Grid{row: r, col: c}
  end
end
