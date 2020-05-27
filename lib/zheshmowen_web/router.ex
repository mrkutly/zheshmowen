defmodule ZheshmowenWeb.Router do
  use ZheshmowenWeb, :router
  alias ZheshmowenWeb.AuthController

  pipeline :auth do
    plug(:accepts, ["json"])
    plug(:fetch_session)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug(:fetch_session)
    plug ZheshmowenWeb.Context
  end

  scope "/auth" do
    pipe_through :auth

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    get "/logout", AuthController, :logout
  end

  scope "/graphql" do
    pipe_through :api

    forward "/playground", Absinthe.Plug.GraphiQL, schema: ZheshmowenWeb.Schema

    forward "/", Absinthe.Plug, schema: ZheshmowenWeb.Schema
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: ZheshmowenWeb.Telemetry
    end
  end
end
