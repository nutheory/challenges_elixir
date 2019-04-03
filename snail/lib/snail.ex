defmodule Snail do
  @doc """

  Converts a matrix to a list by walking around its edges from the top-left going clockwise.

  ![snail walk](http://www.haan.lu/files/2513/8347/2456/snail.png)

  iex> Snail.snail( [ [ 1, 2, 3 ], [ 4, 5, 6 ], [ 7, 8, 9 ] ] )
  [ 1, 2, 3, 6, 9, 8, 7, 4, 5 ]

  """
  # @directions [:right, :down, :left, :up]
  defstruct direction: :right,
            acc: [],
            pos: 0,
            matrix: nil

  @spec snail([[term]]) :: [term]

  def snail(matrix) do
    run(%Snail{matrix: matrix})
  end

  def run(%Snail{matrix: []} = state), do: Enum.reverse(state.acc)

  def run(%Snail{direction: :right} = state) do
    run(%Snail{
      state
      | acc: [Enum.at(state.matrix, state.pos) |> Enum.reverse() | state.acc] |> List.flatten(),
        direction: :down,
        matrix: List.delete_at(state.matrix, state.pos)
    })
  end

  def run(%Snail{direction: :down} = state) do
    nums = [state.matrix |> Enum.reduce([], fn x, acc -> [List.last(x) | acc] end) | state.acc]

    matrix =
      state.matrix |> Enum.reduce([], fn x, acc -> [List.delete_at(x, length(x) - 1) | acc] end)

    run(%Snail{
      state
      | acc: nums |> List.flatten(),
        direction: :left,
        matrix: matrix
    })
  end

  def run(%Snail{direction: :left} = state) do
    run(%Snail{
      state
      | acc: [Enum.at(state.matrix, state.pos) | state.acc] |> List.flatten(),
        direction: :up,
        matrix: List.delete_at(state.matrix, state.pos)
    })
  end

  def run(%Snail{direction: :up} = state) do
    nums = [state.matrix |> Enum.reduce([], fn x, acc -> [hd(x) | acc] end) | state.acc]
    matrix = state.matrix |> Enum.reduce([], fn x, acc -> [List.delete_at(x, 0) | acc] end)

    run(%Snail{
      state
      | acc: nums |> List.flatten(),
        direction: :right,
        matrix: matrix
    })
  end
end
