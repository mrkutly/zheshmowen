defmodule ZheshmowenWeb.Resolvers.Accounts do
  alias Zheshmowen.Accounts
  alias Zheshmowen.Languages

  def user_where(_parent, %{email: email}, _info) do
    {:ok, Accounts.get_user(email)}
  end

  def user_where(_parent, %{id: id}, _info) do
    {:ok, Accounts.get_user(id)}
  end

  def create_user(_parent, args, _info) do
    Accounts.create_user(args)
  end
end
