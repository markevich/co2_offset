defmodule Co2OffsetWeb.Router do
  use Co2OffsetWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_layout, {Co2OffsetWeb.LayoutView, :app}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Co2OffsetWeb do
    pipe_through :browser

    resources("/calculators", CalculatorController, only: [:show])

    live("/", CalculatorLive.New)
    live("/calculators/new", CalculatorLive.New)
  end

  # Other scopes may use custom stacks.
  # scope "/api", Co2OffsetWeb do
  #   pipe_through :api
  # end
end
