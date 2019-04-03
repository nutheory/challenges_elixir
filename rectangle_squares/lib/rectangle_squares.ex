defmodule RectangleSquares do
  def squares_in_rect(lg, sm, count, acc) when count > 0 do
    if(sm > lg) do
      squares_in_rect(lg, sm - lg, count - lg * lg, [lg | acc])
    else
      squares_in_rect(sm, lg - sm, count - sm * sm, [sm | acc])
    end
  end

  def squares_in_rect(l, w) do
    if(l === w) do
      nil
    else
      total = l * w
      sm_num = if l > w, do: w, else: l
      lg_num = if l < w, do: w, else: l
      squares_in_rect(sm_num, lg_num - sm_num, total - sm_num * sm_num, [sm_num])
    end
  end

  def squares_in_rect(_, _, _, acc) do
    Enum.reverse(acc)
  end
end
