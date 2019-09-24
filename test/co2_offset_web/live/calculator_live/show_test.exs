defmodule Co2OffsetWeb.DonationLive.ShowTest do
  use Co2OffsetWeb.ConnCase
  alias Co2Offset.Donations

  setup do
    donation = insert(:donation, original_distance: 642)
    distance_1700 = insert(:distance, distance: 1700)
    distance_10000 = insert(:distance, distance: 10_000)

    distance_278 = insert(:distance, distance: 278)
    distance_2509 = insert(:distance, distance: 2509)
    distance_14720 = insert(:distance, distance: 14_720)

    {:ok, view, html} = live(build_conn(), "/donations/#{donation.id}")

    {
      :ok,
      view: view,
      html: html,
      donation: donation,
      distance_1700: distance_1700,
      distance_10000: distance_10000,
      distance_278: distance_278,
      distance_2509: distance_2509,
      distance_14720: distance_14720
    }
  end

  test "renders /donations/show", %{
    html: new_html,
    donation: donation,
    distance_1700: distance_1700,
    distance_10000: distance_10000
  } do
    assert new_html =~ "$#{donation.original_donation}"
    # plane
    assert new_html =~ "#{round(donation.original_distance)} km"
    assert new_html =~ "#{round(donation.original_co2)} kg"
    assert new_html =~ donation.original_city_from
    assert new_html =~ donation.original_city_to
    # beef
    assert new_html =~ "6.68 kg"
    # car
    assert new_html =~ "1751 km"
    assert new_html =~ distance_1700.from
    assert new_html =~ distance_1700.to
    # chicken
    assert new_html =~ "49 kg"
    # volcano
    assert new_html =~ "0.02 sec"
    # human
    assert new_html =~ "231 days"
    # petrol
    assert new_html =~ "99 liters"
    # train
    assert new_html =~ "10272 km"
    assert new_html =~ distance_10000.from
    assert new_html =~ distance_10000.to
  end

  test "#increase donation", %{
    view: view,
    donation: donation,
    distance_278: distance_278,
    distance_2509: distance_2509,
    distance_14720: distance_14720
  } do
    new_html = render_click(view, :increase_donation)

    # refetch after update
    donation = Donations.get_donation!(donation.id)
    assert new_html =~ "$#{round(donation.original_donation + donation.additional_donation)}"
    # plane
    assert new_html =~
             "#{round(donation.original_distance + donation.additional_distance)} km"

    assert new_html =~ "#{round(donation.original_co2 + donation.additional_co2)} kg"
    assert new_html =~ donation.original_city_from
    assert new_html =~ donation.original_city_to
    assert new_html =~ donation.additional_city_from
    assert new_html =~ donation.additional_city_to
    # beef
    assert new_html =~ "9.57 kg"
    # car
    assert new_html =~ "2509 km"
    assert new_html =~ distance_2509.from
    assert new_html =~ distance_2509.to
    # chicken
    # plane
    assert new_html =~ "920 km"
    assert new_html =~ "331 kg"
    assert new_html =~ distance_278.from
    assert new_html =~ distance_278.to
    # beef
    assert new_html =~ "9.57 kg"
    # car
    assert new_html =~ "2509 km"
    assert new_html =~ distance_2509.from
    assert new_html =~ distance_2509.to
    # chicken
    assert new_html =~ "71 kg"
    # volcano
    assert new_html =~ "0.03 sec"
    # human
    assert new_html =~ "331 days"
    # petrol
    assert new_html =~ "142 liters"
    # train
    assert new_html =~ "14720 km"
    assert new_html =~ distance_14720.from
    assert new_html =~ distance_14720.to
  end

  test "#decrease donation to default", %{
    view: view,
    donation: donation,
    distance_1700: distance_1700,
    distance_10000: distance_10000
  } do
    render_click(view, :increase_donation)
    new_html = render_click(view, :decrease_donation)

    # refetch after update
    donation = Donations.get_donation!(donation.id)

    assert new_html =~ "$#{donation.original_donation}"
    # plane
    assert new_html =~ "#{round(donation.original_distance)} km"
    assert new_html =~ "#{round(donation.original_co2)} kg"
    assert new_html =~ donation.original_city_from
    assert new_html =~ donation.original_city_to
    # beef
    assert new_html =~ "6.68 kg"
    # car
    assert new_html =~ "1751 km"
    assert new_html =~ distance_1700.from
    assert new_html =~ distance_1700.to
    # chicken
    assert new_html =~ "49 kg"
    # volcano
    assert new_html =~ "0.02 sec"
    # human
    assert new_html =~ "231 days"
    # petrol
    assert new_html =~ "99 liters"
    # train
    assert new_html =~ "10272 km"
    assert new_html =~ distance_10000.from
    assert new_html =~ distance_10000.to
  end
end
