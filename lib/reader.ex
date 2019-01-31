defmodule Reader do

  @doc """
  Reads cards' file
  """

  def read_cards do
    {:ok, data} = File.read("cards.txt")
    treat_data(data)
  end

  def my_cards do
    read_cards() |> Map.new(&Map.pop(&1, :card))
  end

  def cards_keys do
    my_cards() |> Map.keys
  end

  defp treat_data(data) do
    data |> String.split("\n") |> Enum.map(&find_card_and_count/1)
  end

  defp find_card_and_count(entry) do
    splited_entry = entry |> String.split(" ")
    card = splited_entry |> Enum.drop(1) |> Enum.join(" ")
    {count, _} = splited_entry |> Enum.at(0) |> :string.to_integer
    %{card: card, count: count}
  end
end
