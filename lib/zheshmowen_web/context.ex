defmodule ZheshmowenWeb.Context do
  @behaviour Plug

  import Plug.Conn
  alias Zheshmowen.{Accounts.Guardian}

  def init(opts), do: opts

  def call(conn, _) do
    case build_context(conn) do
      {:ok, context} ->
        put_private(conn, :absinthe, %{context: context})

      {:error, reason} ->
        conn
        |> send_resp(403, reason)
        |> halt()

      _ ->
        conn
        |> send_resp(400, "Bad Request")
        |> halt()
    end
  end

  @doc """
  Return the current user context based on the session cookie
  """
  def build_context(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, %{"sub" => user_id}} <- authorize(token) do
      {:ok, %{user_id: user_id}}
    else
      _ -> {:ok, %{}}
    end
  end

  defp authorize(token) do
    Guardian.decode_and_verify(token)
  end
end
