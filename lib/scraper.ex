defmodule Scraper do

  @doc """
  Fetch a list of tournments
  """

  def get_decks do
    case HTTPoison.get("https://www.mtggoldfish.com/metagame/standard/full#paper") do
      {:ok, response} ->
        case response.status_code do
          200 ->
            response.body
            |> Floki.find(".archetype-tile")
            |> Enum.map(&extract_name_and_id/1)

          _ -> :error
        end

      _ -> :error
    end
  end

  # def get_decks_by_price do
  #   Scraper.get_decks
  #   |> Enum.sort(&(&1.price |> String.split(" ") |> Enum.get(1) < &2.price) |> String.split(" ") |> Enum.get(1))
  # end

  defp extract_name_and_id({_tag, attrs, children}) do
    [name, price, _] =
      Floki.raw_html(children)
      |> Floki.find(".deck-price-paper")
      |> Floki.text
      |> String.split("\n")

    attrs = Enum.into(attrs, %{})

    %{id: attrs["id"], name: name, price: price}
  end

end
