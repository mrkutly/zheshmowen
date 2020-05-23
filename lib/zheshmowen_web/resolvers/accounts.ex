defmodule ZheshmowenWeb.Resolvers.Accounts do
  alias Zheshmowen.Accounts
  alias Zheshmowen.Languages

  def user_where(_parent, %{email: email}, _resolution) do
    user = Accounts.get_user(email)
    {:ok, user}
  end

  def user_where(_parent, %{id: id}, _resolution) do
    user = Accounts.get_user(id)
    {:ok, user}
  end

  def get_user_groups(parent, _args, _resolution) do
    groups = Languages.get_user_groups(parent)
    {:ok, groups}
  end

  def create_user(_parent, args, _resolution) do
    Accounts.create_user(args)
  end
end
