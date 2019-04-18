defmodule Mix.Tasks.Co2Offset.UpdateCapitalsDistancesCsv do
  use Mix.Task

  @capitals_json_path "priv/tools/capitals.json"
  @distances_csv_path "priv/tools/capitals_distances.csv"

  @moduledoc """
  Update tools/capitals_distances.csv data with actual distances

  This can be used in your application as:

      mix co2_offset.update_capitals_distances_csv
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
        great_circle_distance(
          Enum.at(Enum.at(capitals, 0)["geometry"]["coordinates"], 1),
          Enum.at(Enum.at(capitals, 0)["geometry"]["coordinates"], 0),
          Enum.at(Enum.at(capitals, 1)["geometry"]["coordinates"], 1),
          Enum.at(Enum.at(capitals, 1)["geometry"]["coordinates"], 0)
        )

      capitals ++ [distance]
    end)
  end

  defp great_circle_distance(lat1, lon1, lat2, lon2) do
    rlat1 = :math.pi() * lat1 / 180.0
    rlat2 = :math.pi() * lat2 / 180.0
    theta = lon1 - lon2
    rtheta = :math.pi() * theta / 180.0

    deg_distance =
      :math.acos(
        :math.sin(rlat1) * :math.sin(rlat2) +
          :math.cos(rlat1) * :math.cos(rlat2) * :math.cos(rtheta)
      )

    earth_radius = 6371.0

    round(deg_distance * earth_radius)
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
        %{capitals: capitals ++ [current], combinations: combinations ++ new_combinations}
    end
  end
end
