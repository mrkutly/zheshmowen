defmodule Zheshmowen.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Zheshmowen.Repo,
      # Start the Telemetry supervisor
      ZheshmowenWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Zheshmowen.PubSub},
      # Start the Endpoint (http/https)
      ZheshmowenWeb.Endpoint
      # Start a worker by calling: Zheshmowen.Worker.start_link(arg)
      # {Zheshmowen.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Zheshmowen.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ZheshmowenWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
