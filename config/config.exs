# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :ex_led, ExLedWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "4h5wODXmuU/cAfgCbArFk6flWkLrm3WBiUed5h/byYq4d8F37wcuynmz3o2jGPfH",
  render_errors: [view: ExLedWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ExLed.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "fnX8ZyZl"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :ex_led, ExLedWeb.ControllerSocket,
  secret_auth_key: System.get_env("SECRET_AUTH_KEY") || "SECRET_SAYS_WHAT"

config :ex_led, ExLedWeb.Router,
  username: System.get_env("USERNAME") || "username",
  password: System.get_env("PASSWORD") || "password"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
