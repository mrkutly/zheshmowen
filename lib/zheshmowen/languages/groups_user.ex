defmodule Zheshmowen.Languages.GroupsUser do
  use Ecto.Schema
  import Ecto.Changeset
  alias Zheshmowen.Languages.GroupsUser
  alias Zheshmowen.Languages.Group
  alias Zheshmowen.Accounts.User

  schema "groups_users" do
    field :is_admin, :boolean

    belongs_to(:group, Group)
    belongs_to(:user, User)
    timestamps()
  end

  @doc false
  def changeset(%GroupsUser{} = groups_user, attrs) do
    groups_user
    |> cast(attrs, [:user_id, :group_id, :is_admin])
    |> validate_required([:user_id, :group_id])
    |> unique_constraint([:user_id, :group_id])
  end
end
