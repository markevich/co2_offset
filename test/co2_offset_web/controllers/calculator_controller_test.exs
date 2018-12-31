defmodule Co2OffsetWeb.CalculatorControllerTest do
  use Co2OffsetWeb.ConnCase

  test "show /calculators", %{conn: conn} do
    conn = get(conn, "/calculators/1")
    assert conn.status == 200
  end
end
