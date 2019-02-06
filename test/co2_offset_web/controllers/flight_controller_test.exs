defmodule Co2OffsetWeb.FlightControllerTest do
  use Co2OffsetWeb.ConnCase

  test "index /calculators", %{conn: conn} do
    conn = get(conn, "/flights")
    assert conn.status == 200
  end

  test "index /calculators as default route", %{conn: conn} do
    conn = get(conn, "/")
    assert conn.status == 200
  end
end
