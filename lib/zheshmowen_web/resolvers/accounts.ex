defmodule ZheshmowenWeb.Resolvers.Accounts do
  alias Zheshmowen.Accounts

  def user_where(_parent, %{email: email}, _info) do
    {:ok, Accounts.get_user_by(%{email: email})}
  end

  def user_where(_parent, %{id: id}, _info) do
    {:ok, Accounts.get_user(id)}
  end

  def create_user(_parent, args, _info) do
    Accounts.create_user(args)
  end
end
