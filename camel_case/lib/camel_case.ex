defmodule CamelCase do
  @moduledoc """
  Documentation for CamelCase.
  """

  @doc """
  Hello world.

  ## Examples

      iex> CamelCase.hello()
      :world

  """
  def to_camel_case(str) do
    str
    |> String.split(["-", "_"])
    |> Enum.reduce("", fn w, acc ->
      n =
        if acc == "" do
          acc <> w
        else
          acc <> String.capitalize(w)
        end

      acc = n
    end)
  end
end
