defmodule ZheshmowenWeb.Resolvers.Languages do
  alias Zheshmowen.Languages

  def list_groups(_parent, _args, _info) do
    {:ok, Languages.list_groups()}
  end

  def group_where(_parent, %{id: id}, _info) do
    {:ok, Languages.get_group(id)}
  end

  def group_where(_parent, %{name: name}, _info) do
    {:ok, Languages.get_group_by(%{name: name})}
  end

  def create_group(_parent, args, _info) do
    Languages.create_group(args)
  end
end
