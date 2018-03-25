defmodule Mtgtopdecks do
  @moduledoc """
  Documentation for Mtgtopdecks.
  """

  def compare_decks do
    decks = Scraper.get_decks

    decks |> Enum.map(&compare_with_cards/1)
  end

  def compare_with_cards(deck) do
    deck_cards = deck.cards |> Map.new(&Map.pop(&1, :card))

    %{
      name: deck.name,
      cards: deck_cards |> Enum.map(&return_deck/1)
    }
  end

  def return_deck({k, v}) do
    my_cards = Reader.read_cards |> Map.new(&Map.pop(&1, :card))
    cards_keys = my_cards |> Map.keys
    %{card: k, present: Enum.member?(cards_keys, k), lack: count_cards(k, v.count)}
  end

  def count_cards(card, deck_card_count) do
    my_cards = Reader.read_cards |> Map.new(&Map.pop(&1, :card))
    cards_keys = my_cards |> Map.keys

    if Enum.member?(cards_keys, card) do
      if my_cards[card].count > deck_card_count do
        0
      else
        deck_card_count - my_cards[card].count
      end
    else
      deck_card_count
    end
  end
end
