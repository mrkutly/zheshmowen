defmodule ZheshmowenWeb.Schema.Types do
  use Absinthe.Schema.Notation
  alias Zheshmowen.{Languages, Accounts}
  alias ZheshmowenWeb.Resolvers
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  import_types(Absinthe.Type.Custom, only: [:naive_datetime])

  object :comment do
    field :body, :string
    field :id, :id
    field :inserted_at, :naive_datetime
    field :num_likes, :integer
    field :post, :post, resolve: dataloader(Languages)
    field :updated_at, :naive_datetime
    field :user, :user, resolve: dataloader(Accounts)
  end

  object :group do
    field :current_user_status, :user_status,
      resolve: &Resolvers.Languages.get_current_user_status/3

    field :group_users, list_of(:group_user), resolve: dataloader(Accounts)
    field :id, :id
    field :inserted_at, :naive_datetime
    field :name, :string
    field :posts, list_of(:post), resolve: dataloader(Languages)
    field :slug, :string
    field :updated_at, :naive_datetime
  end

  object :group_user do
    field :id, :id
    field :inserted_at, :naive_datetime
    field :is_admin, :boolean
    field :is_banned, :boolean
    field :is_pending, :boolean
    field :updated_at, :naive_datetime
    field :user, :user, resolve: dataloader(Accounts)
  end

  object :post do
    field :body, :string
    field :comments, list_of(:comment), resolve: dataloader(Languages)
    field :group, :group, resolve: dataloader(Languages)
    field :id, :id
    field :inserted_at, :naive_datetime
    field :num_likes, :integer
    field :updated_at, :naive_datetime
    field :user, :user, resolve: dataloader(Accounts)
  end

  object :user do
    field :affiliation, :string
    field :email, :string
    field :id, :id
    field :inserted_at, :naive_datetime
    field :name, :string
    field :photo_url, :string
    field :updated_at, :naive_datetime
    field :user_groups, list_of(:user_group), resolve: dataloader(Accounts)
  end

  object :user_group do
    field :group, :group, resolve: dataloader(Languages)
    field :id, :id
    field :inserted_at, :naive_datetime
    field :is_admin, :boolean
    field :is_banned, :boolean
    field :is_pending, :boolean
    field :updated_at, :naive_datetime
  end

  object :user_status do
    field :is_admin, :boolean
    field :is_banned, :boolean
    field :is_pending, :boolean
  end
end
