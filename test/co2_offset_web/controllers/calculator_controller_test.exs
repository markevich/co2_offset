defmodule Co2OffsetWeb.CalculatorControllerTest do
  use Co2OffsetWeb.ConnCase, async: true

  setup do
    {
      :ok,
      calculator: insert(:calculator)
    }
  end

  describe "happy path" do
    test "show /calculators", %{conn: conn, calculator: calculator} do
      conn = get(conn, "/calculators/#{calculator.id}")
      assert conn.resp_body =~ calculator.city_from
      assert conn.resp_body =~ calculator.city_to
      assert conn.status == 200
    end
  end
end
