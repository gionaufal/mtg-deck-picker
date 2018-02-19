defmodule Reader do

  @doc """
  Reads cards' file
  """

  def read_cards do
    {:ok, data} = File.read("cards.txt")
    treat_data(data)
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
