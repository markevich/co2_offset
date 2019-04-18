defmodule Co2Offset.Geo.GreatCircleDistance do
  @spec call(number(), number(), number(), number()) :: integer()
  def call(lat1, lon1, lat2, lon2) do
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
end
