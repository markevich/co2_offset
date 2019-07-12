defmodule Mix.Tasks.Co2Offset.UpdateDistancesCsv do
  use Mix.Task

  alias Co2Offset.Geo.GreatCircleDistance

  @capitals_json_path "priv/tools/distances.json"
  @distances_csv_path "priv/tools/distances.csv"

  @moduledoc """
  Update tools/distances.csv data with actual distances

  This can be used in your application as:

      mix co2_offset.update_distances_csv
  """

  @shortdoc "Update distances csv"

  def run(_) do
    generate_combinations_from_json()
    |> add_distances()
    |> write_to_csv()

    IO.puts("Success")
  end

  def generate_combinations_from_json do
    @capitals_json_path
    |> Path.absname()
    |> File.read!()
    |> Jason.decode!()
    |> Enum.reduce(%{capitals: [], combinations: []}, &create_combinations/2)
    |> Map.get(:combinations)
  end

  def add_distances(collection) do
    Enum.map(collection, fn capitals ->
      distance =
        GreatCircleDistance.call(
          Enum.at(Enum.at(capitals, 0)["geometry"]["coordinates"], 1),
          Enum.at(Enum.at(capitals, 0)["geometry"]["coordinates"], 0),
          Enum.at(Enum.at(capitals, 1)["geometry"]["coordinates"], 1),
          Enum.at(Enum.at(capitals, 1)["geometry"]["coordinates"], 0)
        )

      # credo:disable-for-next-line
      capitals ++ [distance]
    end)
  end

  defp write_to_csv(collection) do
    string =
      collection
      |> Enum.map(fn combination ->
        [
          Enum.at(combination, 0)["properties"]["capital"],
          Enum.at(combination, 1)["properties"]["capital"],
          Enum.at(combination, 2)
        ]
      end)
      |> Enum.map(fn combination -> Enum.join(combination, ",") end)
      |> Enum.join("\n")

    @distances_csv_path
    |> Path.absname()
    |> File.write!(string)
  end

  defp create_combinations(current, acc) do
    case acc do
      %{capitals: [], combinations: []} ->
        %{capitals: [current], combinations: []}

      %{capitals: capitals, combinations: combinations} ->
        new_combinations = Enum.map(capitals, fn capital -> [current, capital] end)
        # credo:disable-for-next-line
        %{capitals: capitals ++ [current], combinations: combinations ++ new_combinations}
    end
  end
end
