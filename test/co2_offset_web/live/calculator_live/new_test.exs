defmodule Co2OffsetWeb.DonationLive.NewTest do
  use Co2OffsetWeb.ConnCase

  alias Co2Offset.Donations.DonationSchema
  alias Co2Offset.Repo

  setup do
    {:ok, view, html} = live(build_conn(), "/donations/new")

    {:ok, view: view, html: html}
  end

  test "renders /donations/new", %{html: html} do
    assert html =~ "Offset your flight CO² emissions"
    assert html =~ "Measure your carbon footprint"
  end

  describe "submit" do
    setup do
      airport_from = insert(:airport)
      airport_to = insert(:airport)

      {:ok, airport_from: airport_from, airport_to: airport_to}
    end

    test "creates new donation", %{
      view: view,
      airport_from: airport_from,
      airport_to: airport_to
    } do
      # "wait for elixir slack answer https://elixir-lang.slack.com/archives/C03QQCV4H/p1555569448222400"
      # assert_redirect(
      #   view,
      #   "donations/1",
      #   fn ->
      #     assert render_submit(
      #              view,
      #              :save,
      #              %{
      #                donation: %{
      #                  iata_from: airport_from.iata,
      #                  iata_to: airport_to.iata
      #                }
      #              }
      #            )
      #   end
      # )
      donations_before = Repo.aggregate(DonationSchema, :count, :id)

      render_submit(
        view,
        :save,
        %{
          donation: %{
            iata_from: airport_from.iata,
            iata_to: airport_to.iata
          }
        }
      )

      donations_after = Repo.aggregate(DonationSchema, :count, :id)

      assert(donations_after == donations_before + 1)
    end
  end

  describe "autocomplete" do
    setup do
      airport1 = insert(:airport, name: "Minsk old", city: "Minsk", iata: "MS#")
      airport2 = insert(:airport, name: "Minsk national", city: "Minsk 2", iata: "MQ#")
      airport3 = insert(:airport, name: "Sheremetevo", city: "Moscow", iata: "SV#")
      search_term = "minsk"

      {:ok, airport1: airport1, airport2: airport2, airport3: airport3, search_term: search_term}
    end

    test "autocomplete airport_from", %{
      view: view,
      airport1: airport1,
      airport2: airport2,
      airport3: airport3,
      search_term: search_term
    } do
      render_change(view, :show_iata_from_autocomplete)

      rendered =
        render_change(view, :autocomplete, %{donation: %{iata_from: search_term, iata_to: ""}})

      assert rendered =~ airport1.city
      assert rendered =~ airport1.name
      assert rendered =~ airport1.iata
      assert rendered =~ airport2.city
      assert rendered =~ airport2.name
      assert rendered =~ airport2.iata
      refute rendered =~ airport3.city
      refute rendered =~ airport3.name
      refute rendered =~ airport3.iata
    end

    test "autocomplete airport_to", %{
      view: view,
      airport1: airport1,
      airport2: airport2,
      airport3: airport3
    } do
      render_change(view, :show_iata_to_autocomplete)

      rendered =
        render_change(view, :autocomplete, %{donation: %{iata_from: "", iata_to: "minsk"}})

      assert rendered =~ airport1.city
      assert rendered =~ airport1.name
      assert rendered =~ airport1.iata
      assert rendered =~ airport2.city
      assert rendered =~ airport2.name
      assert rendered =~ airport2.iata
      refute rendered =~ airport3.city
      refute rendered =~ airport3.name
      refute rendered =~ airport3.iata
    end

    test "set_iata_from", %{view: view, airport1: airport1} do
      iata = airport1.iata

      rendered = render_click(view, :set_iata_from, iata)
      assert rendered =~ iata

      socket = :sys.get_state(view.pid).socket
      assert %{iata_from: ^iata} = socket.assigns.changeset.changes
    end

    test "set_iata_to", %{view: view, airport1: airport1} do
      iata = airport1.iata

      rendered = render_click(view, :set_iata_to, iata)
      assert rendered =~ iata

      socket = :sys.get_state(view.pid).socket
      assert %{iata_to: ^iata} = socket.assigns.changeset.changes
    end
  end
end
