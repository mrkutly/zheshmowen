defmodule ZheshmowenWeb.Middleware.RequireAuth do
  @behaviour Absinthe.Middleware

  def call(resolution, _config) do
    case resolution.context do
      %{current_user: _} ->
        resolution

      _ ->
        resolution
        |> Absinthe.Resolution.put_result({:error, "You must be logged in to do that."})
    end
  end
end
