defmodule Scraper do

  @doc """
  Fetch a list of tournments
  """

  def get_decks do
    case HTTPoison.get("https://www.mtggoldfish.com/metagame/standard/full#paper") do
      {:ok, response} ->
        case response.status_code do
          200 ->
            tournments =
              response.body
              |> Floki.find(".archetype-tile")
              |> Enum.map(&extract_name_and_id/1)
              |> Enum.sort(&(&1.name < &2.name))

            {:ok, tournments}

          _ -> :error
        end

      _ -> :error
    end
  end

  defp extract_name_and_id({_tag, attrs, children}) do
    name =
      Floki.raw_html(children)
      |> Floki.find(".deck-price-paper")
      |> Floki.text

    attrs = Enum.into(attrs, %{})

    %{id: attrs["id"], name: name}
  end

end
