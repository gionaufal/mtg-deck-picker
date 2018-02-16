defmodule ScraperTest do
  use ExUnit.Case
  doctest Scraper

  test "has a list with decks" do
    assert is_list(Scraper.get_decks)
  end

  test "list has decks with id, price, link and name" do
    item = Scraper.get_decks |> Enum.at(0)

    assert item == %{id: "44987",
                     link: ["/archetype/standard-mono-red-aggro-44987#paper"],
                     name: "Mono-Red Aggro",
                     price: 279}
  end

  test "sort by price" do
    item1 = Scraper.get_decks_by_price |> Enum.at(0)
    item10 = Scraper.get_decks_by_price |> Enum.at(10)

    assert item1.price < item10.price
  end
end
