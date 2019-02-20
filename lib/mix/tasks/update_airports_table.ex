defmodule Mix.Tasks.Co2Offset.UpdateAirportsTable do
  use Mix.Task
  alias Co2Offset.Repo

  @moduledoc """
  Migrate the data from tools/airports.csv into airports database table

  This can be used in your application as:

      mix co2_offset.update_airports_table
  """

  @shortdoc "Update airports data"

  def run(_) do
    Mix.Task.run("app.start")

    {:ok, _result} = drop_table_sql() |> Repo.query()
    {:ok, _result} = create_table_sql() |> Repo.query()
    {:ok, _result} = copy_table_sql() |> Repo.query()
    {:ok, _result} = delete_bad_iata_sql() |> Repo.query()
  end

  def drop_table_sql do
    """
    DROP TABLE if exists airports;
    """
  end

  def create_table_sql do
    """
    create table airports
                (
                  id          serial primary key,
                  name        varchar(65)       ,
                  iata        char   ( 3)       ,
                  city        varchar(50)       ,
                  country     varchar(50)       ,
                  lat         double precision  ,
                  lon         double precision
                );
    """
  end

  def copy_table_sql do
    """
    COPY airports(name, city, country, iata, lat, lon) FROM PROGRAM '#{data_program()}' WITH (FORMAT CSV);
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
