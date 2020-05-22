defmodule Zheshmowen.Repo do
  use Ecto.Repo,
    otp_app: :zheshmowen,
    adapter: Ecto.Adapters.Postgres
end
