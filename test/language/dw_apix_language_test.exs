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

  test "get all languages" do
    assert languages = DwApix.Language.get_all_languages()

    Enum.map(languages, fn lang ->
      assert true == @required_keys |> Enum.all?(&Map.has_key?(lang, &1))
    end)
  end

  test "get language by code" do
    assert german = DwApix.Language.get_language_by_code("de")
    assert true == @required_keys |> Enum.all?(&Map.has_key?(german, &1))
  end

  test "get language by id" do
    assert english = DwApix.Language.get_language_by_id(2)
    assert true == @required_keys |> Enum.all?(&Map.has_key?(english, &1))
  end

  test "get language data privacy policy by id" do
    assert url = DwApix.Language.get_language_data_privacy_policy_by_id(2)
    assert is_binary(url)
    assert String.contains?(url, "https://api.dw.com/api/detail/article/")
  end
end
