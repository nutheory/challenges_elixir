defmodule Revrot do
  def revrot(str, sz) do
    if sz <= 0 or String.length(str) <= sz or sz > String.length(str) do
      ""
    else
      str
      |> String.to_integer()
      |> Integer.digits()
      |> Enum.chunk(sz)
      |> Enum.map(fn ch ->
        if length(ch) < sz do
          []
        else
          ch
          |> Enum.sum()
          |> (&(rem(&1, 2) === 0)).()
          |> case do
            true ->
              Enum.reverse(ch)
              |> Enum.join("")

            false ->
              cycle(Enum.join(ch, ""))
          end
        end
      end)
      |> Enum.join("")
    end
  end

  defp cycle(str) do
    f = String.first(str)
    str |> String.slice(1, String.length(str)) |> (&(&1 <> f)).()
  end
end
