defmodule ZheshmowenWeb.Resolvers.Accounts do
  alias Zheshmowen.Accounts

  def user_where_email(_parent, %{email: email}, _resolution) do
    user = Accounts.get_user_by({:email, email})
    {:ok, user}
  end
end
