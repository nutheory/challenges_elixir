defmodule RoboscriptOne do
  def highlight(code) do
    String.replace(code, ~r/[0-9]+/, "<span style=\"color: orange\">\\0</span>")
    |> String.replace(~r/[F]+/, "<span style=\"color: pink\">\\0</span>")
    |> String.replace(~r/[L]+/, "<span style=\"color: red\">\\0</span>")
    |> String.replace(~r/[R]+/, "<span style=\"color: green\">\\0</span>")
  end
end
