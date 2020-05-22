defmodule ZheshmowenWeb.Schema do
  use Absinthe.Schema
  import_types(ZheshmowenWeb.Schema.AccountsTypes)

  alias ZheshmowenWeb.Resolvers

  query do
    @desc "Get a user by email"
    field :user_where_email, :user do
      arg(:email, non_null(:string))
      resolve(&Resolvers.Accounts.user_where_email/3)
    end
  end
end
