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
            |> Enum.map(&extract_decks/1)
            |> Enum.map(&treat_price/1)

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
    |> Enum.sort(&(&1.price < &2.price))
  end

  def cards(url) do
    full_url = "https://www.mtggoldfish.com#{url}"

    case HTTPoison.get(full_url) do
      {:ok, response} ->
        case response.status_code do
          200 ->
            response.body
            |> Floki.find(".deck-view-deck-table tr")
            |> Enum.map(&extract_card_and_count/1)
            |> Enum.filter(&(&1))

          _ -> :error
        end

      _ -> :error
    end
  end

  defp extract_decks({_tag, attrs, children}) do
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

    cards = Scraper.cards(link) |> Enum.uniq

    %{id: attrs["id"], name: name, price: price, link: link, cards: cards}
  end

  defp treat_price(map) do
    Map.update!(map, :price, &(String.split(&1, " ")
    |> Enum.at(1)
    |> String.to_integer))
  end

  defp extract_card_and_count({_tag, _attrs, children}) do
    card_data =
      Floki.raw_html(children)
      |> Floki.find("td")
      |> Floki.text
      |> String.split("\n")

    if Enum.count(card_data) == 5 do
      [_, count, card, _, _] = card_data

      {int_count, _} = count |> :string.to_integer

      %{count: int_count, card: card}
    end
  end
end
