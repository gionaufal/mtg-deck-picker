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
        cards:
        [
          %{card: "Vineshaper Mystic", lack: 0, present: true, in_deck: 1, price: 0.18},
          %{card: "Unsummon", lack: 0, present: true, in_deck: 4, price: 0.4},
          %{present: true, card: "Tempest Caller", lack: 0, in_deck: 3, price: 0.6000000000000001},
          %{card: "Naturalize", lack: 0, present: true, in_deck: 2, price: 0.28},
          %{card: "Life Goes On", lack: 0, present: true, in_deck: 1, price: 0.15},
          %{card: "Jade Bearer", lack: 0, present: true, in_deck: 3, price: 0.45},
          %{lack: 0, present: true, card: "Island", in_deck: 5, price: 0.0},
          %{card: "Forest", lack: 0, present: true, in_deck: 5, price: 0.0}, 
          %{card: "Essence Scatter", lack: 0, present: true, in_deck: 2, price: 0.28},
          %{card: "Deeproot Waters", lack: 0, present: true, in_deck: 2, price: 0.5},
          %{present: false, card: "Crashing Tide", lack: 1, in_deck: 1, price: 0.13},
          %{card: "Spell Pierce", lack: 2, present: true, in_deck: 3, price: 0.6},
          %{card: "Negate", lack: 2, present: true, in_deck: 3, price: 0.42},
          %{present: true, card: "Merfolk Branchwalker", lack: 2, in_deck: 4, price: 4.32},
          %{lack: 3, card: "Silvergill Adept", present: true, in_deck: 4, price: 2.24},
          %{card: "Merfolk Mistbinder", lack: 3, present: true, in_deck: 4, price: 5.0},
          %{card: "Jungleborn Pioneer", lack: 3, present: true, in_deck: 4, price: 0.6},
          %{present: false, card: "Unclaimed Territory", lack: 4, in_deck: 4, price: 14.36},
          %{card: "Kumena, Tyrant of Orazca", lack: 4, present: false, in_deck: 4, price: 59.96},
          %{lack: 4, present: false, card: "Kumena's Speaker", in_deck: 4, price: 1.36},
          %{lack: 4, present: false, card: "Hashep Oasis", in_deck: 4, price: 5.2},
          %{card: "Deeproot Elite", in_deck: 4, lack: 4, present: false, price: 14.0},
          %{card: "Botanical Sanctum", in_deck: 4, lack: 4, present: false, price: 36.0}],
          name: "UG",
          cards_lacking: 40,
          unique_cards_lacking: 13
      }
    end
  end
end
