defmodule Mix.Tasks.Co2Offset.UpdateAirportsTable do
  use Mix.Task
  alias Co2Offset.Geo.AirportSchema
  alias Co2Offset.Repo

  @moduledoc """
  Migrate the data from tools/airports.csv into airports database table

  Example of usage from elixir code:
      Mix.Task.run("co2_offset.update_airports_table")

  Example of usage from terminal:
      mix co2_offset.update_airports_table
  """

  def run(_) do
    Application.ensure_all_started(:co2_offset)

    {:ok, _result} = truncate_table_sql() |> Repo.query()
    {:ok, _result} = copy_table_sql() |> Repo.query()
    {:ok, _result} = delete_bad_iata_sql() |> Repo.query()

    new_count = Repo.aggregate(AirportSchema, :count, :id)

    IO.puts("Import completed. New airports count: #{new_count}")
  end

  def truncate_table_sql do
    """
    TRUNCATE airports;
    """
  end

  def copy_table_sql do
    """
    COPY airports(name, city, country, iata, lat, long) FROM PROGRAM '#{data_program()}' WITH (FORMAT CSV);
    """
  end

  def delete_bad_iata_sql do
    """
    delete from airports where iata='\\N';
    """
  end

  def data_program do
    file_path = Path.absname("priv/tools/airports.dat")

    # cut - cuts listed columns from file
    # sed - removes lines that have IATA value: "\N"
    "cut -d \",\" -f 2,3,4,5,7,8 #{file_path}"
  end
end
