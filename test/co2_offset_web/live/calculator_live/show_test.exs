defmodule Co2OffsetWeb.CalculatorLive.ShowTest do
  use Co2OffsetWeb.ConnCase
  alias Co2OffsetWeb.CalculatorLive.Show

  setup do
    calculator = insert(:calculator, original_distance: 642)

    {:ok, view, html} =
      mount(Co2OffsetWeb.Endpoint, Show, session: %{path_params: %{"id" => calculator.id}})

    {
      :ok,
      view: view, html: html, calculator: calculator
    }
  end

  test "renders /calculators/show", %{html: html} do
    assert html =~ "Compensated CO²"
    assert html =~ "231.12"
    assert html =~ "Plane"
    assert html =~ "642.0"
    assert html =~ "Car"
    assert html =~ "1750.91"
    assert html =~ "Train"
    assert html =~ "10272.0"
    assert html =~ "Petrol"
    assert html =~ "98.77"
    assert html =~ "Human"
    assert html =~ "231.12"
    assert html =~ "Beef"
    assert html =~ "6.68"
    assert html =~ "Chicken"
    assert html =~ "49.49"
    assert html =~ "Etno volcano"
    assert html =~ "0.02"
  end
end
