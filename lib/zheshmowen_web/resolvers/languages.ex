defmodule ZheshmowenWeb.Resolvers.Languages do
  alias Zheshmowen.Languages

  def list_groups(_parent, _args, _resolution) do
    groups = Languages.list_groups()
    {:ok, groups}
  end

  def group_where(_parent, %{id: id}, _resolution) do
    group = Languages.get_group(id)
    {:ok, group}
  end

  def group_where(_parent, %{name: name}, _resolution) do
    group = Languages.get_group_by(%{name: name})
    {:ok, group}
  end

  def get_group_users(parent, _args, _resolution) do
    users = Languages.get_group_users(parent)
    {:ok, users}
  end
end
