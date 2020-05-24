defmodule Zheshmowen.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Ueberauth.Auth
  alias Zheshmowen.Repo
  alias Zheshmowen.Accounts.User

  def data() do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  def query(queryable, _params), do: queryable

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

  def find_or_create_user(%Auth{info: %{email: email, name: name, image: photo_url}}) do
    case get_user_by(%{email: email}) do
      nil -> {:ok, create_user(%{email: email, name: name, photo_url: photo_url})}
      user -> {:ok, user}
    end
  end

  @doc """
  Gets a user by their id

  ## Example

      iex> get_user(1)
      %Zheshmowen.Accounts.User{}

  """
  def get_user(id) do
    Repo.get!(User, id)
  end

  @doc """
  Gets a user by their email

  ## Example

      iex> get_user_by([email: "mark@test.com"])
      %Zheshmowen.Accounts.User{}

  """
  def get_user_by(attrs) do
    Repo.get_by(User, attrs)
  end

  @doc """
  Updates a user.

  ## Example

      iex> user = get_user(1)
      iex> update_user(user, %{affiliation: "Citizen Potawatomi Nation"})
      {:ok, %Zheshmowen.Accounts.User{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end
end
