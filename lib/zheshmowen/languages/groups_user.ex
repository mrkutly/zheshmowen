defmodule Zheshmowen.Languages.GroupsUser do
  @moduledoc """
  Represents an association between a Group and a User
  """
  use Ecto.Schema
  import Ecto.{Changeset, Query}
  alias Zheshmowen.{Accounts.User, Languages.Group, Languages.GroupsUser, Repo}

  schema "groups_users" do
    field :is_admin, :boolean, default: false
    field :is_banned, :boolean, default: false
    field :is_pending, :boolean, default: true

    belongs_to(:group, Group)
    belongs_to(:user, User)
    timestamps()
  end

  @doc false
  def changeset(%GroupsUser{} = groups_user, attrs) do
    groups_user
    |> cast(attrs, [:user_id, :group_id, :is_admin, :is_banned, :is_pending])
    |> validate_required([:user_id, :group_id])
    |> unique_constraint([:user_id, :group_id])
  end

  defmodule Policy do
    use Pundit.DefaultPolicy

    def edit?(%GroupsUser{group_id: group_id}, user_id) do
      from(gu in GroupsUser,
        where: gu.user_id == ^user_id and gu.group_id == ^group_id,
        select: gu.is_admin
      )
      |> Repo.one()
    end
  end
end
