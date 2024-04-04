defmodule TuneUp.Repo do
  use Ecto.Repo,
    otp_app: :tune_up,
    adapter: Ecto.Adapters.Postgres
end
