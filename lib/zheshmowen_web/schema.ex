defmodule ZheshmowenWeb.Schema do
  use Absinthe.Schema
  import_types(ZheshmowenWeb.Schema.Types)

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

  mutation do
    @desc "Creates a user"
    field :sign_up, :user do
      arg(:name, non_null(:string))
      arg(:email, non_null(:string))
      arg(:affiliation, :string)
      resolve(&Resolvers.Accounts.create_user/3)
    end
  end
end
