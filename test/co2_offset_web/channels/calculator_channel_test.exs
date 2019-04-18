defmodule Co2OffsetWeb.CalculatorChannelTest do
  use Co2OffsetWeb.ChannelCase

  alias Co2Offset.Converters

  setup do
    {:ok, _, socket} =
      Co2OffsetWeb.ApplicationSocket
      |> socket("user:id", %{})
      |> subscribe_and_join(Co2OffsetWeb.CalculatorChannel, "calculator:1")

    {:ok, socket: socket}
  end

  test "value_updated broadcasts to calculator:1", %{socket: socket} do
    push(socket, "value_updated", %{"plane_km" => "5.0"})

    expected = %{new_values: Converters.from_plane(5.0)}

    assert_broadcast("value_updated", ^expected)
  end
end
