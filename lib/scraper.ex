defmodule Scraper do

  @doc """
  Fetch a list of decks from MTGGoldfish
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

  @doc """
  Fetch a list of decks from MTGGoldfish sorted by price
  """

  def get_decks_by_price do
    Scraper.get_decks
    |> Enum.map(&treat_price/1)
    |> Enum.sort(&(&1.price < &2.price))
  end

  defp extract_name_and_id({_tag, attrs, children}) do
    [name, price, _] =
      Floki.raw_html(children)
      |> Floki.find(".deck-price-paper")
      |> Floki.text
      |> String.split("\n")

    link =
      Floki.raw_html(children)
      |> Floki.find(".deck-price-paper a")
      |> Floki.attribute("href")

    attrs = Enum.into(attrs, %{})

    %{id: attrs["id"], name: name, price: price, link: link}
  end

  defp treat_price(map) do
    Map.update!(map, :price, &(String.split(&1, " ")
    |> Enum.at(1)
    |> String.to_integer))
  end
end
