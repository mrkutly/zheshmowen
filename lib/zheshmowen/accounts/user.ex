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

    has_many :user_groups, GroupsUser
    many_to_many :groups, Group, join_through: GroupsUser

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :email, :affiliation, :photo_url])
    |> validate_required([:name, :email])
    |> validate_format(:email, ~r/@.*\./)
    |> validate_length(:name, min: 2, max: 50)
    |> unique_constraint(:email, downcase: true)
  end
end
