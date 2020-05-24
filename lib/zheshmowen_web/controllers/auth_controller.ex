defmodule ZheshmowenWeb.AuthController do
  use ZheshmowenWeb, :controller
  alias Zheshmowen.Accounts

  plug Ueberauth

  def logout(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(external: System.get_env("FRONTEND_URL") <> "/login")
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> redirect(external: System.get_env("FRONTEND_URL") <> "/login")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    # if everything is chill
    case Accounts.find_or_create_user(auth) do
      {:ok, user} ->
        conn
        |> put_session(:current_user, user.id)
        |> redirect(external: System.get_env("FRONTEND_URL"))

      {:error, _} ->
        conn
        |> redirect(external: System.get_env("FRONTEND_URL") <> "/login")
    end
  end
end
