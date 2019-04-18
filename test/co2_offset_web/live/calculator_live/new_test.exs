defmodule Co2OffsetWeb.CalculatorLive.NewTest do
  use Co2OffsetWeb.ConnCase

  alias Co2Offset.Calculators.Calculator
  alias Co2Offset.Repo
  alias Co2OffsetWeb.CalculatorLive.New

  setup do
    {:ok, view, html} = mount(Co2OffsetWeb.Endpoint, New, session: %{})

    {:ok, view: view, html: html}
  end

  test "renders /calculators/new", %{html: html} do
    assert html =~ "Offset your flight CO² emissions"
    assert html =~ "Measure your carbon footprint"
  end

  describe "submit" do
    setup do
      airport_from = insert(:airport)
      airport_to = insert(:airport)

      {:ok, airport_from: airport_from, airport_to: airport_to}
    end

    test "creates new calculator", %{
      view: view,
      airport_from: airport_from,
      airport_to: airport_to
    } do
      # "wait for elixir slack answer https://elixir-lang.slack.com/archives/C03QQCV4H/p1555569448222400"
      # assert_redirect(
      #   view,
      #   "calculators/1",
      #   fn ->
      #     assert render_submit(
      #              view,
      #              :save,
      #              %{
      #                calculator: %{
      #                  iata_from: airport_from.iata,
      #                  iata_to: airport_to.iata
      #                }
      #              }
      #            )
      #   end
      # )
      calculators_before = Repo.aggregate(Calculator, :count, :id)

      render_submit(
        view,
        :save,
        %{
          calculator: %{
            iata_from: airport_from.iata,
            iata_to: airport_to.iata
          }
        }
      )

      calculators_after = Repo.aggregate(Calculator, :count, :id)

      assert(calculators_after == calculators_before + 1)
    end
  end
end
