defmodule Co2Offset.Geo.Distance do
  use Ecto.Schema

  @moduledoc """
  Capitals distance model. Generated from 3rd party data.
  Used for "Same distance as blocks"
  """

  schema "distances" do
    field :from, :string
    field :to, :string
    field :distance, :integer
  end
end
