defmodule Mix.Tasks.Co2Offset.UpdateCapitalsDistancesTable do
  use Mix.Task
  alias Co2Offset.Geo.CapitalsDistance
  alias Co2Offset.Repo

  @moduledoc """
  Migrate the data from tools/airports.csv into airports database table

  Example of usage from elixir code:
      Mix.Task.run("co2_offset.update_capitals_distances")

  Example of usage from terminal:
      mix co2_offset.update_capitals_distances
  """

  def run(_) do
    Application.ensure_all_started(:co2_offset)

    {:ok, _result} = truncate_table_sql() |> Repo.query()
    {:ok, _result} = copy_table_sql() |> Repo.query()

    new_count = Repo.aggregate(CapitalsDistance, :count, :id)

    IO.puts("Import completed. New distances count: #{new_count}")
  end

  def truncate_table_sql do
    """
    TRUNCATE capitals_distances;
    """
  end

  def copy_table_sql do
    """
    COPY capitals_distances(capital_from, capital_to, distance) FROM PROGRAM '#{data_program()}' WITH (FORMAT CSV);
    """
  end

  def data_program do
    file_path = Path.absname("priv/tools/capitals_distances.csv")

    # cut - cuts listed columns from file
    # sed - removes lines that have IATA value: "\N"
    "cut -d \",\" -f 1,2,3 #{file_path}"
  end
end
