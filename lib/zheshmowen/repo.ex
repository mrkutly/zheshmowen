defmodule Zheshmowen.Repo do
  use Ecto.Repo,
    otp_app: :zheshmowen,
    adapter: Ecto.Adapters.Postgres

  @like_regex ~r/[\% _]/

  def like_sanitize(value) when is_binary(value) do
    String.replace(value, @like_regex, "")
  end
end
