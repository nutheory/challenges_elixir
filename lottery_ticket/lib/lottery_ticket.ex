defmodule LotteryTicket do
  def bingo(ticket, win) do
    winners =
      ticket
      |> Enum.reduce([], fn [head | tail], acc ->
        check =
          head
          |> String.graphemes()
          |> Enum.filter(fn char ->
            <<c::utf8>> = char
            c == hd(tail)
          end)

        if length(check) > 0, do: [check | acc], else: acc
      end)

    if length(winners) >= win, do: "Winner!", else: "Loser!"
  end
end
