import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :wavely, WavelyWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "RRSPoX8mjaB6Z1U5xWL2nDqwOKM0hxKxUZA2qZHaoUc5ipZHU2H4+Q5uXAEXQnTN",
  server: false

# In test we don't send emails.
config :wavely, Wavely.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
