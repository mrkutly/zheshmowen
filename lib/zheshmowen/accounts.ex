defmodule Zheshmowen.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Zheshmowen.Repo
  alias Zheshmowen.Accounts.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Gets a user by their id

  ## Example

      iex> get_user(1)
      %Zheshmowen.Accounts.User{
        __meta__: #Ecto.Schema.Metadata<:loaded, "users">,
        affiliation: nil,
        email: "mark@test.com",
        groups: #Ecto.Association.NotLoaded<association :groups is not loaded>,
        id: 1,
        inserted_at: ~N[2020-05-22 21:43:43],
        name: "mark",
        photo_url: nil,
        updated_at: ~N[2020-05-22 21:43:43]
      }

  """
  def get_user(id) do
    Repo.get!(User, id)
  end

  @doc """
  Gets a user by their email

  ## Example

      iex> get_user_by([email: "mark@test.com"])
      %Zheshmowen.Accounts.User{
        __meta__: #Ecto.Schema.Metadata<:loaded, "users">,
        affiliation: nil,
        email: "mark@test.com",
        groups: #Ecto.Association.NotLoaded<association :groups is not loaded>,
        id: 1,
        inserted_at: ~N[2020-05-22 21:43:43],
        name: "mark",
        photo_url: nil,
        updated_at: ~N[2020-05-22 21:43:43]
      }

  """
  def get_user_by(attrs) do
    Repo.get_by!(User, attrs)
  end

  @doc """
  Updates a user.

  ## Example

      iex> user = get_user(1)
      iex> update_user(user, %{affiliation: "Citizen Potawatomi Nation"})
      {:ok,
      %Zheshmowen.Accounts.User{
        __meta__: #Ecto.Schema.Metadata<:loaded, "users">,
        affiliation: "Citizen Potawatomi Nation",
        email: "mark@test.com",
        groups: #Ecto.Association.NotLoaded<association :groups is not loaded>,
        id: 1,
        inserted_at: ~N[2020-05-22 21:43:43],
        name: "mark",
        photo_url: nil,
        updated_at: ~N[2020-05-23 18:26:27]
      }}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end
end
