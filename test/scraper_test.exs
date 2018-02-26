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

      assert item == %{id: "44987",
        link: ["/archetype/standard-mono-red-aggro-44987#paper"],
        name: "Mono-Red Aggro",
        price: 292,
        cards: [
          %{card: "Bomat Courier", count: 4},
          %{card: "Fanatical Firebrand", count: 2},
          %{card: "Soul-Scar Mage", count: 4},
          %{card: "Earthshaker Khenra", count: 4},
          %{card: "Kari Zev, Skyship Raider", count: 2},
          %{card: "Ahn-Crop Crasher", count: 4},
          %{card: "Hazoret the Fervent", count: 4},
          %{card: "Shock", count: 4},
          %{card: "Abrade", count: 2},
          %{card: "Invigorated Rampage", count: 4},
          %{card: "Lightning Strike", count: 4},
          %{card: "Mountain", count: 17},
          %{card: "Scavenger Grounds", count: 1},
          %{card: "Sunscorched Desert", count: 4},
          %{card: "Chandra's Defeat", count: 2},
          %{card: "Release the Gremlins", count: 1},
          %{card: "Abrade", count: 1},
          %{card: "Harsh Mentor", count: 4},
          %{card: "Key to the City", count: 1},
          %{card: "Aethersphere Harvester", count: 2},
          %{card: "Pia Nalaar", count: 3},
          %{card: "Sand Strangler", count: 1}
        ]
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
