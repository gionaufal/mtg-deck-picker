defmodule MtgtopdecksTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest Mtgtopdecks

  test "compare decks with cards from file" do
    use_cassette "mtgtopdecks_compare_decks" do
      compared_deck = Mtgtopdecks.compare_decks |> Enum.at(0)
      assert compared_deck == %{
        # TODO: make the method return decks like this
        # name: "Mono-Red Aggro",
        # have: [
        #   %{card: "Shock", count: 2},
        #   %{card: "Mountain", count: 17}
        # ],
        # need: [
        #   %{card: "Bomat Courier", count: 4},
        #   %{card: "Fanatical Firebrand", count: 2},
        #   %{card: "Soul-Scar Mage", count: 4},
        #   %{card: "Earthshaker Khenra", count: 4},
        #   %{card: "Kari Zev, Skyship Raider", count: 2},
        #   %{card: "Ahn-Crop Crasher", count: 4},
        #   %{card: "Hazoret the Fervent", count: 4},
        #   %{card: "Shock", count: 2},
        #   %{card: "Abrade", count: 2},
        #   %{card: "Invigorated Rampage", count: 4},
        #   %{card: "Lightning Strike", count: 4},
        #   %{card: "Scavenger Grounds", count: 1},
        #   %{card: "Sunscorched Desert", count: 4},
        #   %{card: "Chandra's Defeat", count: 2},
        #   %{card: "Release the Gremlins", count: 1},
        #   %{card: "Abrade", count: 1},
        #   %{card: "Harsh Mentor", count: 4},
        #   %{card: "Key to the City", count: 1},
        #   %{card: "Aethersphere Harvester", count: 2},
        #   %{card: "Pia Nalaar", count: 3},
        #   %{card: "Sand Strangler", count: 1}
        # ]
        name: "Mono-Red Aggro",
        cards: [
          %{card: "Abrade", present: false, lack: 1},
          %{card: "Aethersphere Harvester", lack: 2, present: false},
          %{card: "Ahn-Crop Crasher", lack: 3, present: true},
          %{card: "Bomat Courier", lack: 4, present: false},
          %{present: false, card: "Chandra's Defeat", lack: 2},
          %{present: false, card: "Earthshaker Khenra", lack: 4},
          %{card: "Fanatical Firebrand", lack: 0, present: true},
          %{card: "Harsh Mentor", lack: 4, present: false},
          %{present: false, card: "Hazoret the Fervent", lack: 4},
          %{present: false, card: "Invigorated Rampage", lack: 4},
          %{present: false, card: "Kari Zev, Skyship Raider", lack: 2},
          %{present: false, card: "Key to the City", lack: 1},
          %{card: "Lightning Strike", lack: 4, present: false},
          %{card: "Mountain", lack: 0, present: true},
          %{card: "Pia Nalaar", lack: 3, present: false},
          %{present: false, card: "Release the Gremlins", lack: 1},
          %{present: false, card: "Sand Strangler", lack: 1},
          %{card: "Scavenger Grounds", present: false, lack: 1},
          %{card: "Shock", present: true, lack: 1},
          %{present: false, card: "Soul-Scar Mage", lack: 4},
          %{card: "Sunscorched Desert", lack: 4, present: false}]
      }
    end
  end
end
