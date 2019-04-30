defmodule Co2OffsetWeb.CalculatorLive.ShowTest do
  use Co2OffsetWeb.ConnCase
  alias Co2OffsetWeb.CalculatorLive.Show

  setup do
    calculator = insert(:calculator, original_distance: 642)
    distance_1700 = insert(:capitals_distance, distance: 1700)
    distance_10000 = insert(:capitals_distance, distance: 10_000)

    {:ok, view, html} =
      mount(Co2OffsetWeb.Endpoint, Show, session: %{path_params: %{"id" => calculator.id}})

    {
      :ok,
      view: view,
      html: html,
      calculator: calculator,
      distance_1700: distance_1700,
      distance_10000: distance_10000
    }
  end

  test "renders /calculators/show", %{
    html: html,
    distance_1700: distance_1700,
    distance_10000: distance_10000
  } do
    assert html =~ "Compensated CO²"
    assert html =~ "231"
    assert html =~ "Plane"
    assert html =~ "642"
    assert html =~ "Car"
    assert html =~ "1751"
    assert html =~ distance_1700.from
    assert html =~ distance_1700.to
    assert html =~ "Train"
    assert html =~ "10272"
    assert html =~ distance_10000.from
    assert html =~ distance_10000.to
    assert html =~ "Petrol"
    assert html =~ "99"
    assert html =~ "Human"
    assert html =~ "231"
    assert html =~ "Beef"
    assert html =~ "6.68"
    assert html =~ "Chicken"
    assert html =~ "49"
    assert html =~ "Etno volcano"
    assert html =~ "0.02"
  end
end
