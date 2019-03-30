defmodule Co2OffsetWeb.FlightControllerTest do
  use Co2OffsetWeb.ConnCase

  test "/flights/new", %{conn: conn} do
    conn = get(conn, "/flights/new")
    assert conn.status == 200
  end

  test "/flights/new as default route", %{conn: conn} do
    conn = get(conn, "/")
    assert conn.status == 200
  end
end
