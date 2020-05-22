defmodule ZheshmowenWeb.Schema.AccountsTypes do
  use Absinthe.Schema.Notation

  object :user do
    field :id, :id
    field :email, :string
    field :name, :string
    field :affiliation, :string
    field :photo_url, :string
  end
end
