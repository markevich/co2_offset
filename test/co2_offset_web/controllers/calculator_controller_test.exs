defmodule Co2OffsetWeb.CalculatorControllerTest do
  use Co2OffsetWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
  end
end
