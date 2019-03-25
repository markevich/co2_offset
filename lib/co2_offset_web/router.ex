defmodule Co2OffsetWeb.Router do
  use Co2OffsetWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Co2OffsetWeb do
    pipe_through :browser

    get("/", FlightController, :new)
    resources("/flights", FlightController, only: [:new])
    resources("/calculators", CalculatorController, only: [:show])
  end

  # Other scopes may use custom stacks.
  # scope "/api", Co2OffsetWeb do
  #   pipe_through :api
  # end
end
