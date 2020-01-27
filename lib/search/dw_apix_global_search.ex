defmodule DwApix.GlobalSearch do
  @dw_base_api_url "https://api.dw.com"
  @dw_global_search_pattern "/api/search/global"

  @moduledoc """
  [Deutsche Welle] (https://dw.com) API Client in Elixir.

  Global search module
  """

  @doc """
  Searches for `terms` in a default query pattern.

  The default query pattern uses `languageId=2` (English), `endDate` of today
  and `startDate` from two years ago. Since the API takes a while, the timeout
  is set to 50_000 ms.
  """
  def global_search(terms) when is_binary(terms) do
    params = Map.put(default_params(), "terms", terms)

    uri_string =
      @dw_base_api_url
      |> URI.parse()
      |> URI.merge(@dw_global_search_pattern)
      |> Map.put(:query, URI.encode_query(params))
      |> URI.to_string()

    DwApix.do_get(uri_string, [{:timeout, 30_000}, {:recv_timeout, 30_000}])
  end

  defp default_params do
    %{
      "languageId" => 2,
      "startDate" =>
        Date.utc_today()
        |> Date.add(-730)
        |> Date.to_string(),
      "endDate" => Date.utc_today()
    }
  end
end
