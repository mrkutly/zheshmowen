defmodule ZheshmowenWeb.Resolvers.Languages do
  alias Zheshmowen.Languages

  def list_groups(_parent, _args, _info) do
    {:ok, Languages.list_groups()}
  end

  def group_where(_parent, %{id: id}, _info) do
    {:ok, Languages.get_group(id)}
  end

  def group_where(_parent, attrs, _info) do
    {:ok, Languages.get_group_by(attrs)}
  end

  def groups_where(_parent, %{name: name}, _info) do
    {:ok, Languages.get_groups_where_like(%{name: name})}
  end

  def create_group(_parent, args, _info) do
    Languages.create_group(args)
  end

  def join_group(_parent, %{group_id: group_id}, %{
        context: %{current_user: user}
      }) do
    Languages.add_user_to_group(%{user_id: user.id, group_id: group_id})
  end

  def join_group(_parent, _args, %{context: %{}}) do
    {:error, "You must be logged in to do that."}
  end

  def add_post(_parent, %{group_id: group_id, body: body}, %{
        context: %{current_user: user}
      }) do
    Languages.create_post(%{group_id: group_id, user_id: user.id, body: body})
  end

  def add_post(_parent, _args, %{context: %{}}) do
    {:error, "You must be logged in to do that."}
  end

  def add_comment(_parent, %{post_id: post_id, body: body}, %{
        context: %{current_user: user}
      }) do
    Languages.create_comment(%{post_id: post_id, user_id: user.id, body: body})
  end

  def add_comment(_parent, _args, %{context: %{}}) do
    {:error, "You must be logged in to do that."}
  end

  def get_posts(_parent, %{group_id: group_id}, _info) do
    {:ok, Languages.list_posts(%{group_id: group_id})}
  end

  def get_current_user_status(%{id: group_id}, _args, %{context: %{current_user: user}}) do
    {:ok, Languages.get_user_status(user, group_id)}
  end

  def get_current_user_status(_parent, _args, _info), do: {:ok, nil}
end
