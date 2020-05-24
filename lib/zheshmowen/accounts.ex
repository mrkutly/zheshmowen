defmodule Zheshmowen.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Argon2
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
    Repo.get_by!(User, attrs)
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

  @doc """
  Authenticates a user

  ## Example

      iex> authenticate_user("mark@test.com", "the_real_password!")
      {:ok, %User{}}

      iex> authenticate_user("not_a_real_user", "the_real_password!")
      {:error, :invalid_credentials}

      iex> authenticate_user("mark@test.com", "the_wrong_password")
      {:error, :invalid_credentials}

  """
  def authenticate_user(email, plain_text_password) do
    query = from u in User, where: u.email == ^email

    case Repo.one(query) do
      nil ->
        Argon2.no_user_verify()
        {:error, :invalid_credentials}

      user ->
        if Argon2.verify_pass(plain_text_password, user.password_hash) do
          {:ok, user}
        else
          {:error, :invalid_credentials}
        end
    end
  end
end
