defmodule DwApixTest do
  use ExUnit.Case
  doctest DwApix

  @required_keys [
    "apiVersion",
    "supportedLanguages",
    "trackingConfig",
    "epgConfig",
    "urlConfig",
    "appUpdate"
  ]

  test "get config" do
    assert {:ok, config} = DwApix.get_config()
    assert true == @required_keys |> Enum.all?(&Map.has_key?(config, &1))
  end

  test "get version" do
    assert {:ok, config} = DwApix.get_config()
    assert "1.0.4" == Map.get(config, "apiVersion")
  end
end
