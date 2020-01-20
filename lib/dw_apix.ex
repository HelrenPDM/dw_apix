defmodule DwApix do
  @dw_base_api_url "https://api.dw.com"
  @dw_config_pattern "/api/config/init"

  @moduledoc """
  [Deutsche Welle] (https://dw.com) API Client in Elixir.
  """

  @doc """
  Returns the current API version.
  """
  def get_version do
    case get_config() do
      {:ok, config } -> config["apiVersion"]
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Returns the config endpoint.
  """
  def get_config do
    uri_string =
      @dw_base_api_url
      |> URI.parse()
      |> URI.merge(@dw_config_pattern)
      |> URI.to_string()

    do_request(uri_string)
  end
  
  def do_request(url) do
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
end
