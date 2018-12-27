defmodule Co2Offset.Converters do
  alias Co2Offset.Converters.Plane

  @moduledoc """
  This module is a root converter context.
  """

  @spec from_plane(float()) ::
          {float(), nonempty_improper_list(any(), %{co2: float(), km: float(), type: :plane})}
  def from_plane(plane_km) do
    co2 = Plane.convert(plane_km, :co2_from_km)

    Plane.convert_and_structure({co2, []})
  end
end
