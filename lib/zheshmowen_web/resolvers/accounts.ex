defmodule ZheshmowenWeb.Resolvers.Accounts do
  alias Zheshmowen.Accounts

  def me(_parent, _args, %{context: %{current_user: id}}) do
    {:ok, Accounts.get_user(id)}
  end

  def me(_parent, _args, %{context: %{}}) do
    {:ok, nil}
  end

  def user_where(_parent, %{email: email}, _info) do
    {:ok, Accounts.get_user_by(%{email: email})}
  end

  def user_where(_parent, %{id: id}, _info) do
    {:ok, Accounts.get_user(id)}
  end
end
