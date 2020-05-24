defmodule ZheshmowenWeb.Schema do
  use Absinthe.Schema
  import_types(ZheshmowenWeb.Schema.Types)

  alias ZheshmowenWeb.Resolvers
  alias Zheshmowen.{Accounts, Languages}

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

    @desc "Gets posts for a given group page"
    field :posts, list_of(:post) do
      arg(:group_id, non_null(:id))
      resolve(&Resolvers.Languages.get_posts/3)
    end
  end

  mutation do
    @desc "Creates a user"
    field :sign_up, :login_response do
      arg(:name, non_null(:string))
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))
      arg(:affiliation, :string)
      resolve(&Resolvers.Accounts.create_user/3)
    end

    @desc "Creates a group"
    field :create_group, :group do
      arg(:name, non_null(:string))
      resolve(&Resolvers.Languages.create_group/3)
    end

    @desc "Logs a user in"
    field :login, :login_response do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))
      resolve(&Resolvers.Accounts.login/3)
    end

    @desc "Adds the current user to a group"
    field :join_group, :user_group do
      arg(:group, non_null(:join_group_input))
      resolve(&Resolvers.Languages.join_group/3)
    end

    @desc "Adds a post to a group page"
    field :add_post, :post do
      arg(:group_id, non_null(:id))
      arg(:body, non_null(:string))
      resolve(&Resolvers.Languages.add_post/3)
    end

    @desc "Adds a comment to a post"
    field :add_comment, :comment do
      arg(:post_id, non_null(:id))
      arg(:body, non_null(:string))
      resolve(&Resolvers.Languages.add_comment/3)
    end
  end
end
