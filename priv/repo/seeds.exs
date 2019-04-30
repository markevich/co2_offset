# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
Mix.Task.run("co2_offset.update_airports_table")
Mix.Task.run("co2_offset.update_distances_csv")
Mix.Task.run("co2_offset.update_distances_table")
