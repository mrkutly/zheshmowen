defmodule ZheshmowenWeb.Resolvers.Accounts do
  alias Zheshmowen.{Accounts, Accounts.Guardian}

  def user_where(_parent, %{email: email}, _info) do
    {:ok, Accounts.get_user_by(%{email: email})}
  end

  def user_where(_parent, %{id: id}, _info) do
    {:ok, Accounts.get_user(id)}
  end

  def create_user(_parent, args, _info) do
    with {:ok, user} <- Accounts.create_user(args),
         {:ok, jwt, _} <- Guardian.encode_and_sign(user) do
      {:ok, %{token: jwt}}
    end
  end

  def login(_parent, %{email: email, password: password}, _info) do
    with {:ok, user} <- Accounts.authenticate_user(email, password),
         {:ok, jwt, _} <- Guardian.encode_and_sign(user) do
      {:ok, %{token: jwt}}
    end
  end
end
