defmodule Josephus do
  def survivor(n, k) do
    elimination(Enum.to_list(1..n), n, k, 1, 0)
  end

  defp elimination([head | tail], _, _, _, _) when tail === [], do: head

  defp elimination(acc, len, inc, count_inc, index_array) when index_array === len do
    elimination(acc, len, inc, count_inc, 0)
  end

  defp elimination(acc, len, inc, count_inc, index_array) when count_inc === inc do
    elimination(List.delete_at(acc, index_array), len - 1, inc, 0, index_array - 1)
  end

  defp elimination(acc, len, inc, count_inc, index_array) do
    elimination(acc, len, inc, count_inc + 1, index_array + 1)
  end
end
