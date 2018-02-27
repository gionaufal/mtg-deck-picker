defmodule ReaderTest do
  use ExUnit.Case
  doctest Reader

  test "reads list of cards" do
    assert is_list(Reader.read_cards)
  end

  test "list has cards and counts" do
    card = Reader.read_cards |> Enum.at(0)
    assert card == %{card: "Hyena Pack", count: 1}
  end
end
