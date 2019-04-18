defmodule Co2OffsetWeb.CalculatorLive.New do
  use Phoenix.LiveView
  alias Co2Offset.Calculators
  alias Co2Offset.Calculators.Calculator
  alias Co2OffsetWeb.Router.Helpers, as: Routes

  @moduledoc """
  Live view for Flights/new page.
  Dynamic content:
    flight_from, flight_to inputs
    form validation and submition
  """

  def render(assigns) do
    Co2OffsetWeb.CalculatorView.render("new.html", assigns)
  end

  def mount(_session, socket) do
    {:ok,
     assign(socket, %{
       changeset: Calculators.change_calculator(%Calculator{})
     })}
  end

  # def handle_event("validate", %{"calculator" => params}, socket) do
  #   IO.puts("OASDKLASJDALSKJDALSKDJ")
  #   changeset =
  #     %Calculator{}
  #     |> Co2Offset.Calculators.change_calculator(params)
  #     |> Map.put(:action, :insert)

  #   IO.puts(params)
  #   IO.puts(changeset)
  #   {:noreply, assign(socket, changeset: changeset)}
  # end

  def handle_event("save", %{"calculator" => calculator_params}, socket) do
    case Calculators.create_calculator(calculator_params) do
      {:ok, calculator} ->
        {:stop,
         socket
         |> redirect(to: Routes.calculator_path(socket, :show, calculator))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
