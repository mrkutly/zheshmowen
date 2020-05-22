defmodule Zheshmowen.Languages do
  @moduledoc """
  The Languages context.
  """

  import Ecto.Query, warn: false
  alias Zheshmowen.Repo

  alias Zheshmowen.Languages.{Group, GroupsUser}

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
  def get_group(id) when is_integer(id) do
    Repo.get!(Group, id)
  end

  @doc """
  Gets a group by their name
  """
  def get_group_by(name) do
    Repo.get_by!(Group, name: name)
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
end
