defmodule Zheshmowen.Languages do
  @moduledoc """
  The Languages context.
  """

  import Ecto.Query, warn: false
  alias Zheshmowen.Repo

  alias Zheshmowen.Languages.{Group, GroupsUser, Post}
  alias Zheshmowen.Accounts.User

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
  Gets the list of groups that a user is in

  ## Example

      iex> get_user_groups(%User{id: 1})
      [
        %Zheshmowen.Languages.GroupsUser{
          __meta__: #Ecto.Schema.Metadata<:loaded, "groups_users">,
          group: %Zheshmowen.Languages.Group{
            __meta__: #Ecto.Schema.Metadata<:loaded, "groups">,
            id: 1,
            inserted_at: ~N[2020-05-22 21:22:31],
            name: "Bodéwadmimwen",
            updated_at: ~N[2020-05-22 21:22:31],
            users: #Ecto.Association.NotLoaded<association :users is not loaded>
          },
          group_id: 1,
          id: 2,
          inserted_at: ~N[2020-05-22 21:43:47],
          is_admin: false,
          updated_at: ~N[2020-05-22 21:43:47],
          user: #Ecto.Association.NotLoaded<association :user is not loaded>,
          user_id: 1
        }
      ]
  """
  def get_user_groups(%User{id: id}) do
    from(gu in GroupsUser,
      where: gu.user_id == ^id,
      preload: [:group]
    )
    |> Repo.all()
  end

  @doc """
  Gets the list of users that are in a group

  ## Example

      iex> get_group_users(%Group{id: 1})
      [
        %Zheshmowen.Languages.GroupsUser{
          __meta__: #Ecto.Schema.Metadata<:loaded, "groups_users">,
          group: #Ecto.Association.NotLoaded<association :group is not loaded>,
          group_id: 1,
          id: 2,
          inserted_at: ~N[2020-05-22 21:43:47],
          is_admin: false,
          updated_at: ~N[2020-05-22 21:43:47],
          user: %Zheshmowen.Accounts.User{
            __meta__: #Ecto.Schema.Metadata<:loaded, "users">,
            affiliation: nil,
            email: "mark@test.com",
            groups: #Ecto.Association.NotLoaded<association :groups is not loaded>,
            id: 1,
            inserted_at: ~N[2020-05-22 21:43:43],
            name: "mark",
            photo_url: nil,
            updated_at: ~N[2020-05-22 21:43:43]
          },
          user_id: 1
        }
      ]
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

      iex> add_post_to_group(%{group_id: 1, user_id: 1, body: "Bozho jayek!"})
      {:ok, %Group{}}

      iex> add_post_to_group(%{user_id: 1, body: "Bozho jayek!"})
      {:error, %Ecto.Changeset{}}
  """
  def add_post_to_group(attrs) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end
end
