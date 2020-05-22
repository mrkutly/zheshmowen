defmodule Zheshmowen.Languages.Group do
  use Ecto.Schema
  import Ecto.Changeset
  alias Zheshmowen.Languages.{Group, GroupsUser}
  alias Zheshmowen.Accounts.User

  schema "groups" do
    field :name, :string
    many_to_many :users, User, join_through: GroupsUser
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
