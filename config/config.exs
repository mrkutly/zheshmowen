# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :zheshmowen,
  ecto_repos: [Zheshmowen.Repo]

# Configures the endpoint
config :zheshmowen, ZheshmowenWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "gIZFHCqMiJWFbKt+cFnvkk00Ror4WG6hfGi+icK80hcFmaGkwUA4iE2q/rxsPzKn",
  render_errors: [view: ZheshmowenWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Zheshmowen.PubSub,
  live_view: [signing_salt: "XbJBW2t1"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
