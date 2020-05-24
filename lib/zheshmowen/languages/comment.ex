defmodule Zheshmowen.Languages.Comment do
  @moduledoc """
  Represents a Comment on a Post
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Zheshmowen.Languages.{Post, Comment}
  alias Zheshmowen.Accounts.User

  schema "comments" do
    field :body, :string
    field :num_likes, :integer, default: 0
    belongs_to(:post, Post)
    belongs_to(:user, User)
    timestamps()
  end

  @doc false
  def changeset(%Comment{} = post, attrs) do
    post
    |> cast(attrs, [:body, :user_id, :post_id, :num_likes])
    |> validate_required([:body, :user_id, :post_id])
  end
end
