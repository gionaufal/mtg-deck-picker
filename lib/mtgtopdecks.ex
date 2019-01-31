defmodule Mtgtopdecks do
  @moduledoc """
  This module compares decks scraped with `Scraper`and compares with
  cards from cards.txt file, threated by `Reader`.
  """

  def compare_decks do
    Scraper.get_decks
    |> Enum.map(&compare_with_cards/1)
    |> Enum.sort(&(&1.cards_lacking < &2.cards_lacking))
  end

  def compare_with_cards(deck) do
    cards = deck.cards
            |> Map.new(&Map.pop(&1, :card))
            |> Enum.map(&return_deck/1)
            |> Enum.sort(&(&1.lack < &2.lack))

    %{
      name: deck.name,
      cards: cards,
      cards_lacking: Enum.reduce(cards, 0, fn card, acc -> card.lack + acc end),
      unique_cards_lacking: Enum.count(cards, fn card -> card.lack > 0 end)
    }
  end

  def return_deck({k, v}) do
    %{
      card: k,
      in_deck: v.count,
      price: v.price,
      present: Enum.member?(Reader.cards_keys(), k),
      lack: count_cards(k, v.count)
    }
  end

  def count_cards(card, deck_card_count) do
    if Enum.member?(Reader.cards_keys, card) do
      if Reader.my_cards()[card].count > deck_card_count do
        0
      else
        deck_card_count - Reader.my_cards()[card].count
      end
    else
      deck_card_count
    end
  end
end
