defmodule Wavely.Repo do
  use Ecto.Repo,
    otp_app: :wavely,
    adapter: Ecto.Adapters.Postgres
end
