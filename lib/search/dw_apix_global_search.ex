defmodule DwApix.GlobalSearch do
  @dw_base_api_url "https://api.dw.com"
  @dw_global_search_pattern "/api/search/global"

  @moduledoc """
  """

  @doc """
  Searches for `terms` in a default query pattern.

  The default query pattern uses `languageId=2` (English), `endDate` of today
  and `startDate` from two years ago. Since the API takes a while, the timeout
  is set to 50_000 ms.
  """
  def global_search(terms) when is_binary(terms) do
    params =
      Map.put(default_params(), "terms", terms)

    uri_string =
      @dw_base_api_url
      |> URI.parse()
      |> URI.merge(@dw_global_search_pattern)
      |> Map.put(:query, URI.encode_query(params))
      |> URI.to_string()

    IO.inspect(uri_string)
    do_request(uri_string)
  end

  defp do_request(url) do
    case HTTPoison.get(url, [], [timeout: 50_000, recv_timeout: 50_000]) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        # HTTP status 200 (OK) and we have a body
        case Jason.decode(body) do
          {:ok, decoded} -> {:ok, decoded}
          {:error, error} -> {:error, error}
        end

      {:ok, %HTTPoison.Response{status_code: status_code}} ->
        # Any other status
        {:error, status_code}

      {:error, error} ->
        # some error during request
        {:error, error}
    end
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
