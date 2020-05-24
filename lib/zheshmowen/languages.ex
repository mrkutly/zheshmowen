defmodule Zheshmowen.Languages do
  @moduledoc """
  The Languages context.
  """

  import Ecto.Query, warn: false
  alias Zheshmowen.Repo

  alias Zheshmowen.Languages.{Group, GroupsUser, Post, Comment}
  alias Zheshmowen.Accounts.User

  def data() do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  def query(queryable, _params), do: queryable

  @doc """
  Returns the list of groups.

  ## Examples

      iex> list_groups()
      [%Group{}, ...]

  """
  def list_groups do
    Repo.all(Group)
  end

  @doc """
  Creates a group.

  ## Examples

      iex> create_group(%{name: "Bodéwadmimwen"})
      {:ok, %Group{}}

      iex> create_group(%{name: 12345})
      {:error, %Ecto.Changeset{}}

  """
  def create_group(attrs \\ %{}) do
    %Group{}
    |> Group.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Gets a group by their id
  """
  def get_group(id) do
    Repo.get!(Group, id)
  end

  @doc """
  Gets a group by their name
  """
  def get_group_by(%{name: name}) do
    Repo.get_by!(Group, name: name)
  end

  @doc """
  Returns a list of GroupsUsers with the Group preloaded

  ## Example

      iex> get_user_groups(%User{id: 1})
      [%Zheshmowen.Languages.GroupsUser{}, ...]
  """
  def get_user_groups(%User{id: id}) do
    from(gu in GroupsUser,
      where: gu.user_id == ^id,
      preload: [:group]
    )
    |> Repo.all()
  end

  @doc """
  Returns a list of GroupsUsers with the User preloaded

  ## Example

      iex> get_group_users(%Group{id: 1})
      [%Zheshmowen.Languages.GroupsUser{}, ...]
  """
  def get_group_users(%Group{id: id}) do
    from(gu in GroupsUser,
      where: gu.group_id == ^id,
      preload: [:user]
    )
    |> Repo.all()
  end

  @doc """
  Updates a group.
  """
  def update_group(%Group{} = group, attrs) do
    group
    |> Group.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Adds a user to a group

  ## Examples

      iex> add_user_to_group(%{group_id: 1, user_id: 1, is_admin: false})
      {:ok, %Group{}}

      iex> add_user_to_group(%{user_id: 1, is_admin: false})
      {:error, %Ecto.Changeset{}}
  """
  def add_user_to_group(attrs) do
    %GroupsUser{}
    |> GroupsUser.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Adds a post to a group

  ## Examples

      iex> create_post(%{group_id: 1, user_id: 1, body: "Bozho jayek!"})
      {:ok, %Post{}}

      iex> create_post(%{user_id: 1, body: "Bozho jayek!"})
      {:error, %Ecto.Changeset{}}
  """
  def create_post(attrs) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Adds a comment to a post

  ## Examples

      iex> create_comment(%{post_id: 1, user_id: 1, body: "Bozho jayek!"})
      {:ok, %Comment{}}

      iex> create_comment(%{user_id: 1, body: "Bozho jayek!"})
      {:error, %Ecto.Changeset{}}
  """
  def create_comment(attrs) do
    %Comment{}
    |> Comment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Returns a list of Posts for a group

  ## Example

      iex> list_posts(%User{id: 1})
      [%Zheshmowen.Languages.Post{}, ...]
  """
  def list_posts(%{group_id: id}) do
    from(p in Post,
      where: p.group_id == ^id,
      select: p
    )
    |> Repo.all()
  end
end
