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
    DwApix.get_config()["apiVersion"]
  end

  @doc """
  Returns the config endpoint.
  """
  def get_config do
    res = HTTPoison.get!(URI.merge(URI.parse(@dw_base_api_url), @dw_config_pattern))
    Jason.decode!(res.body)
  end
end
