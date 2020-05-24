defmodule Zheshmowen.Languages.Post do
  @moduledoc """
  Represents a Post on a Language Group page
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Zheshmowen.Languages.{Comment, Group, Post}
  alias Zheshmowen.Accounts.User

  schema "posts" do
    field :body, :string
    field :num_likes, :integer, default: 0
    belongs_to(:group, Group)
    belongs_to(:user, User)
    has_many(:comments, Comment)
    timestamps()
  end

  @doc false
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:body, :user_id, :group_id, :num_likes])
    |> validate_required([:body, :user_id, :group_id])
  end
end
