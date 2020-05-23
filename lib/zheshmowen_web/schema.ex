defmodule ZheshmowenWeb.Schema do
  use Absinthe.Schema
  import_types(ZheshmowenWeb.Schema.AccountsTypes)

  alias ZheshmowenWeb.Resolvers

  query do
    @desc "Get a list of all groups"
    field :groups, list_of(:group) do
      resolve(&Resolvers.Languages.list_groups/3)
    end

    @desc "Get a single group"
    field :group_where, :group do
      arg(:name, :string)
      arg(:id, :id)
      resolve(&Resolvers.Languages.group_where/3)
    end

    @desc "Get a user by email"
    field :user_where, :user do
      arg(:email, :string)
      arg(:id, :id)
      resolve(&Resolvers.Accounts.user_where/3)
    end
  end
end
