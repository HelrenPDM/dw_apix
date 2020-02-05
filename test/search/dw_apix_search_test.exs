defmodule DwApixTest.Search do
  use ExUnit.Case
  doctest DwApix.GlobalSearch

  @filter_parameters_keys [
    "categoryIds",
    "contentIds",
    "contentTypes",
    "endDate",
    "programIds",
    "sortByDate",
    "startDate",
    "terms"
  ]

  test "search term=bauhaus" do
    assert {:ok, res} = DwApix.GlobalSearch.global_search("bauhaus")
    assert filter_params = Map.get(res, "filterParameters") 
    assert true == @filter_parameters_keys |> Enum.all?(&Map.has_key?(filter_params, &1))
  end
end
