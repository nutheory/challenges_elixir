defmodule PokerHand do
  @result %{win: 1, loss: 2, tie: 3}
  alias Card

  def compare(player, opponent) do
    rank_p = read_hand(format_string(player))
    rank_o = read_hand(format_string(opponent))

    cond do
      rank_p > rank_o ->
        @result.win

      rank_p < rank_o ->
        @result.loss

      rank_p === rank_o ->
        sort_p = high_card_order(format_string(player))
        sort_o = high_card_order(format_string(opponent))
        highest = find_highest(sort_p, sort_o)

        cond do
          highest === [] ->
            @result.tie

          elem(hd(highest), 0) > elem(hd(highest), 1) ->
            @result.win

          elem(hd(highest), 0) < elem(hd(highest), 1) ->
            @result.loss

          true ->
            @result.tie
        end
    end
  end

  def format_string(str) do
    Enum.map(String.split(str, " "), fn s ->
      case Card.new(s) do
        {:ok, res} -> res
        {:error, message} -> message
      end
    end)
  end

  def read_hand(hand) do
    cond do
      # straight flush
      elem(is_straight(hand), 0) && is_flush(hand) ->
        800 + elem(is_straight(hand), 1)

      # 4 of a kind
      elem(of_a_kind(hand), 0) === 4 ->
        700 + elem(of_a_kind(hand), 1)

      # full house
      length(group_by_kind(hand)) === 2 ->
        600 + calc_cards(group_by_kind(hand), 2)

      # flush
      is_flush(hand) ->
        500 + hd(high_card_order(hand)).num_value

      # straight
      elem(is_straight(hand), 0) ->
        400 + elem(is_straight(hand), 1)

      # three_of_a_kind
      elem(of_a_kind(hand), 0) === 3 ->
        300 + calc_cards(group_by_kind(hand), 1)

      # two pair
      length(group_by_kind(hand)) === 3 ->
        200 + calc_cards(group_by_kind(hand), 2)

      # pair
      length(group_by_kind(hand)) === 4 ->
        100 + calc_cards(group_by_kind(hand), 1)

      true ->
        hd(high_card_order(hand)).num_value
    end
  end

  defp calc_cards(card_list, amnt) do
    Enum.sort(card_list)
    |> Enum.reverse()
    |> Enum.take(amnt)
    |> Enum.reduce(0, fn crd, acc ->
      acc + elem(crd, 0) * elem(crd, 1)
    end)
  end

  defp find_highest(sort_p, sort_o) do
    Enum.map(0..4, fn x ->
      if Enum.at(sort_p, x).num_value !== Enum.at(sort_o, x).num_value do
        {Enum.at(sort_p, x).num_value, Enum.at(sort_o, x).num_value}
      end
    end)
    |> Enum.filter(fn n -> n !== nil end)
  end

  defp high_card_order(cards) do
    Enum.sort_by(cards, & &1.num_value, &>=/2)
  end

  defp group_by_kind(cards) do
    Enum.group_by(cards, &Map.fetch(&1, :num_value))
    |> Enum.map(fn {k, v} -> {length(v), elem(k, 1)} end)
  end

  defp is_flush(cards) do
    Enum.filter(tl(cards), fn crd -> hd(cards).suit !== crd.suit end)
    |> Enum.empty?()
  end

  defp is_straight(cards) do
    {Enum.with_index(tl(high_card_order(cards)), 1)
     |> Enum.filter(fn crd ->
       hd(high_card_order(cards)).num_value - elem(crd, 1) !== elem(crd, 0).num_value
     end)
     |> Enum.empty?(), hd(high_card_order(cards)).num_value}
  end

  defp of_a_kind(cards) do
    group_by_kind(cards) |> Enum.sort() |> Enum.reverse() |> List.first()
  end
end

defmodule Card do
  defstruct(
    num_value: nil,
    suit: nil,
    code: nil
  )

  def new(card) do
    {:ok,
     %Card{
       num_value: sanitize_num_value(String.first(card)),
       suit: sanitize_suit(String.last(card)),
       code: card
     }}
  end

  defp sanitize_num_value(val) do
    cond do
      val === "A" -> 14
      val === "K" -> 13
      val === "Q" -> 12
      val === "J" -> 11
      val === "T" -> 10
      true -> String.to_integer(val)
    end
  end

  defp sanitize_suit(suit) do
    cond do
      suit === "H" -> "hearts"
      suit === "C" -> "clubs"
      suit === "S" -> "spades"
      suit === "D" -> "diamonds"
      true -> "none"
    end
  end
end
