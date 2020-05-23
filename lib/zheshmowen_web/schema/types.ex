defmodule ZheshmowenWeb.Schema.Types do
  use Absinthe.Schema.Notation
  alias ZheshmowenWeb.Resolvers

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

    field :groups, list_of(:user_group) do
      resolve(&Resolvers.Accounts.get_user_groups/3)
    end
  end

  object :group do
    interface(:node)
    field :id, :id
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
    field :name, :string

    field :users, list_of(:group_user) do
      resolve(&Resolvers.Languages.get_group_users/3)
    end
  end

  object :user_group do
    interface(:node)
    field :id, :id
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
    field :group, :group
    field :is_admin, :boolean
  end

  object :group_user do
    interface(:node)
    field :id, :id
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
    field :user, :user
    field :is_admin, :boolean
  end
end
