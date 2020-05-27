defmodule ZheshmowenWeb.Context do
  @behaviour Plug

  import Plug.Conn
  alias Zheshmowen.Accounts

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
  Return the current user context based on the authorization header
  """
  def build_context(conn) do
    conn
    |> get_session(:current_user)
    |> get_user_from_session
  end

  def get_user_from_session(user_id) when is_integer(user_id) do
    user = Accounts.get_user(user_id)
    {:ok, %{current_user: user}}
  end

  def get_user_from_session(_), do: {:ok, %{}}

  # def build_context(conn) do
  #   with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
  #        {:ok, %{"sub" => user_id}} <- authorize(token) do
  #     {:ok, %{current_user: user_id}}
  #   else
  #     _ -> {:ok, %{}}
  #   end
  # end

  # defp authorize(token) do
  #   Guardian.decode_and_verify(token)
  # end
end
