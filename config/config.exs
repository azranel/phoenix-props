# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :props, Props.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "mUdcl4hhIfWfNJBcmknmVMH5mAv6lr/67EzUjObOipHWbEBf0bTSl0GCmG+JLvhP",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: Props.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

# Configure HAML parser
config :phoenix, :template_engines,
  haml: PhoenixHaml.Engine

# Configure uberauth
config :ueberauth, Ueberauth,
  providers: [
    google: {Ueberauth.Strategy.Google, []}
  ]

if Mix.env == "dev" do
  import_config "#{Mix.env}.secret.exs"
end
