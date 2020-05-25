defmodule Zheshmowen.Languages.Group do
  @moduledoc """
  Represents a Language Group
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Zheshmowen.Languages.{Group, GroupsUser, Post}
  alias Zheshmowen.Accounts.User

  schema "groups" do
    field :name, :string
    field :slug, :string
    has_many :group_users, GroupsUser
    many_to_many :users, User, join_through: GroupsUser
    has_many :posts, Post
    timestamps()
  end

  @doc false
  def changeset(%Group{} = group, attrs) do
    attrs = create_slug(attrs)

    group
    |> cast(attrs, [:name, :slug])
    |> validate_required([:name, :slug])
    |> unique_constraint(:name)
    |> unique_constraint(:slug)
  end

  def create_slug(%{name: name}) do
    slug =
      name
      |> String.downcase()
      |> String.replace(~r/\s/i, "-")

    %{name: name, slug: slug}
  end
end
