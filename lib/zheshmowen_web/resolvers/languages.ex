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

  def join_group(_parent, %{group: %{id: group_id, is_admin: is_admin}}, %{
        context: %{user_id: user_id}
      }) do
    Languages.add_user_to_group(%{user_id: user_id, group_id: group_id, is_admin: is_admin})
  end

  def join_group(_parent, _args, %{context: %{}}) do
    {:error, "You must be logged in to do that."}
  end
end
