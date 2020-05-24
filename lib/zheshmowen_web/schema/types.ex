defmodule ZheshmowenWeb.Schema.Types do
  use Absinthe.Schema.Notation
  alias Zheshmowen.{Languages, Accounts}
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  import_types(Absinthe.Type.Custom, only: [:naive_datetime])

  object :user do
    field :id, :id
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
    field :email, :string
    field :name, :string
    field :affiliation, :string
    field :photo_url, :string

    field :user_groups, list_of(:user_group), resolve: dataloader(Accounts)
  end

  object :group do
    field :id, :id
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
    field :name, :string

    field :group_users, list_of(:group_user), resolve: dataloader(Accounts)
  end

  object :user_group do
    field :id, :id
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
    field :is_admin, :boolean
    field :group, :group, resolve: dataloader(Languages)
  end

  object :group_user do
    field :id, :id
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
    field :user, :user, resolve: dataloader(Accounts)
    field :is_admin, :boolean
  end

  object :login_response do
    field :token, :string
  end

  input_object :join_group_input do
    field :id, non_null(:id)
    field :is_admin, :boolean
  end

  object :post do
    field :id, :id
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
    field :body, :string
    field :num_likes, :integer
    field :comments, list_of(:comment), resolve: dataloader(Languages)
    field :user, :user, resolve: dataloader(Accounts)
    field :group, :group, resolve: dataloader(Languages)
  end

  object :comment do
    field :id, :id
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
    field :body, :string
    field :num_likes, :integer
    field :user, :user, resolve: dataloader(Accounts)
    field :post, :post, resolve: dataloader(Languages)
  end
end
