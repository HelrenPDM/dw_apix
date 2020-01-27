defmodule DwApixTest.Language do
  use ExUnit.Case
  doctest DwApix.Language

  @required_keys [
    "id",
    "languageCode",
    "regionCode",
    "rtl",
    "displayNameEnglish",
    "displayNameLocalized",
    "defaultChannel",
    "dataPrivacyPolicyUrl"
  ]

  test "get languages" do
    assert languages = DwApix.Language.get_all_languages()

    Enum.map(languages, fn lang ->
      assert true == @required_keys |> Enum.all?(&Map.has_key?(lang, &1))
    end)
  end
end
