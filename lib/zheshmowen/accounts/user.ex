defmodule Zheshmowen.Accounts.User do
  @moduledoc """
  Represents a User
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Argon2
  alias Zheshmowen.Accounts.User
  alias Zheshmowen.Languages.{Group, GroupsUser}

  schema "users" do
    field :name, :string
    field :email, :string
    field :affiliation, :string
    field :photo_url, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    has_many :user_groups, GroupsUser
    many_to_many :groups, Group, join_through: GroupsUser

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :email, :affiliation, :photo_url, :password])
    |> validate_required([:name, :email, :password])
    |> validate_format(:email, ~r/@.*\./)
    |> validate_length(:name, min: 2, max: 50)
    |> validate_length(:password, min: 8, max: 30)
    |> unique_constraint(:email, downcase: true)
    |> put_password_hash()
  end

  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    put_change(changeset, :password_hash, Argon2.hash_pwd_salt(password))
  end

  defp put_password_hash(changeset), do: changeset
end
