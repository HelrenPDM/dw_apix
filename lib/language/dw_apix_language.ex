defmodule DwApix.Language do
  @moduledoc """
  [Deutsche Welle] (https://dw.com) API Client in Elixir.

  Language module
  """

  @doc """
  Return all provided languages infos.
  """
  def get_all_languages() do
    DwApix.get_config()["supportedLanguages"]
  end

  @doc """
  Return language info by code.
  """
  def get_language_by_code(code) do
    Enum.find(DwApix.Language.get_all_languages(), fn lang ->
      lang["languageCode"] == code
    end)
  end

  @doc """
  Return language info by id.
  """
  def get_language_by_id(id) do
    Enum.find(DwApix.Language.get_all_languages(), fn lang ->
      lang["id"] == id
    end)
  end
end
