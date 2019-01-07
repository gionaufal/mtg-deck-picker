defmodule ScraperTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest Scraper

  test "has a list with decks" do
    use_cassette "scraper_get_decks" do
      assert is_list(Scraper.get_decks)
    end
  end

  test "list has decks with id, price, link and name" do
    use_cassette "scraper_get_decks" do
      item = Scraper.get_decks |> Enum.at(0)

      assert item == %{
        id: "44987",
        link: ["/archetype/standard-mono-red-aggro-44987#paper"],
        name: "Mono-Red Aggro",
        price: 292,
        cards: [
          %{card: "Abrade", count: 3, price: 4.5},
          %{count: 2, card: "Aethersphere Harvester", price: 6.04},
          %{count: 4, card: "Ahn-Crop Crasher", price: 1.4},
          %{count: 4, card: "Bomat Courier", price: 4.92},
          %{count: 2, card: "Chandra's Defeat", price: 0.74},
          %{count: 4, card: "Earthshaker Khenra", price: 6.24},
          %{card: "Fanatical Firebrand", count: 2, price: 0.3},
          %{count: 4, card: "Harsh Mentor", price: 4.64},
          %{card: "Hazoret the Fervent", count: 4, price: 80.0},
          %{card: "Invigorated Rampage", count: 4, price: 1.2},
          %{card: "Kari Zev, Skyship Raider", count: 2, price: 2.64},
          %{card: "Key to the City", count: 1, price: 0.46},
          %{card: "Lightning Strike", count: 4, price: 0.68},
          %{card: "Mountain", count: 17, price: 0.0},
          %{card: "Pia Nalaar", count: 3, price: 1.2},
          %{card: "Release the Gremlins", count: 1, price: 0.38},
          %{count: 1, card: "Sand Strangler", price: 0.2},
          %{card: "Scavenger Grounds", count: 1, price: 2.25},
          %{card: "Shock", count: 4, price: 0.6},
          %{card: "Soul-Scar Mage", count: 4, price: 10.0},
          %{card: "Sunscorched Desert", count: 4, price: 0.8}]
      }
    end
  end

  test "sort by price" do
    use_cassette "scraper_get_decks_by_price" do
      item1 = Scraper.get_decks_by_price |> Enum.at(0)
      item10 = Scraper.get_decks_by_price |> Enum.at(10)

      assert item1.price < item10.price
    end
  end
end
