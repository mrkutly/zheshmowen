defmodule ZheshmowenWeb.Schema do
  use Absinthe.Schema
  import_types(ZheshmowenWeb.Schema.Types)

  alias ZheshmowenWeb.Resolvers
  alias Zheshmowen.{Accounts, Languages}
  alias ZheshmowenWeb.Middleware.RequireAuth

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Languages, Languages.data())
      |> Dataloader.add_source(Accounts, Accounts.data())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

  query do
    @desc "Gets the current logged in user"
    field :me, :user do
      resolve(&Resolvers.Accounts.me/3)
    end

    @desc "Get a list of all groups"
    field :groups, list_of(:group) do
      resolve(&Resolvers.Languages.list_groups/3)
    end

    @desc "Get a single group"
    field :group_where, :group do
      arg(:name, :string)
      arg(:slug, :string)
      arg(:id, :id)
      resolve(&Resolvers.Languages.group_where/3)
    end

    @desc "Get multiple groups"
    field :groups_where, list_of(:group) do
      arg(:name, :string)
      resolve(&Resolvers.Languages.groups_where/3)
    end

    @desc "Gets posts for a given group page"
    field :posts, list_of(:post) do
      arg(:group_id, non_null(:id))
      resolve(&Resolvers.Languages.get_posts/3)
    end

    @desc "Get a user by email"
    field :user_where, :user do
      arg(:email, :string)
      arg(:id, :id)
      resolve(&Resolvers.Accounts.user_where/3)
    end
  end

  mutation do
    @desc "Adds a comment to a post"
    field :add_comment, :comment do
      arg(:post_id, non_null(:id))
      arg(:body, non_null(:string))

      middleware(RequireAuth)
      resolve(&Resolvers.Languages.add_comment/3)
    end

    @desc "Adds a post to a group page"
    field :add_post, :post do
      arg(:group_id, non_null(:id))
      arg(:body, non_null(:string))

      middleware(RequireAuth)
      resolve(&Resolvers.Languages.add_post/3)
    end

    @desc "Creates a group"
    field :create_group, :group do
      arg(:name, non_null(:string))

      middleware(RequireAuth)
      resolve(&Resolvers.Languages.create_group/3)
    end

    @desc "Adds user to group (pending admin approval)"
    field :join_group, :user_group do
      arg(:group_id, non_null(:id))

      middleware(RequireAuth)
      resolve(&Resolvers.Languages.join_group/3)
    end
  end
end
