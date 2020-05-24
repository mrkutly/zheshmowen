defmodule ZheshmowenWeb.Schema.Types do
  use Absinthe.Schema.Notation
  alias Zheshmowen.{Languages, Accounts}
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  import_types(Absinthe.Type.Custom, only: [:naive_datetime])

  interface :node do
    field :id, :id
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime

    resolve_type(fn
      %{email: _, name: _}, _ -> :user
      %{name: _}, _ -> :group
      _, _ -> nil
    end)
  end

  object :user do
    interface(:node)
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
    interface(:node)
    field :id, :id
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
    field :name, :string

    field :group_users, list_of(:group_user), resolve: dataloader(Accounts)
  end

  object :user_group do
    interface(:node)
    field :id, :id
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
    field :is_admin, :boolean
    field :group, :group, resolve: dataloader(Languages)
  end

  object :group_user do
    interface(:node)
    field :id, :id
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
    field :user, :user, resolve: dataloader(Accounts)
    field :is_admin, :boolean
  end

  object :login_response do
    field :token, :string
  end

  input_object :group_input do
    field :id, :id
    field :name, :string
  end
end
