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
    has_many :group_users, GroupsUser
    many_to_many :users, User, join_through: GroupsUser
    has_many :posts, Post
    timestamps()
  end

  @doc false
  def changeset(%Group{} = group, attrs) do
    group
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
