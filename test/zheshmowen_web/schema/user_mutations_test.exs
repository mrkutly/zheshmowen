defmodule ZheshmowenWeb.UserMutationsTest do
  use ZheshmowenWeb.ConnCase
  alias Zheshmowen.{Accounts, Languages, Languages.Group}

  @join_group_mutation """
  mutation JoinGroup($id: ID) {
    joinGroup(group_id: $id) {
      isAdmin
      isBanned
      isPending
      group {
        name
        id
      }
    }
  }
  """

  test "mutation: join_group" do
    {:ok, user} =
      Accounts.create_user(%{
        email: "jenkins@test.com",
        name: "jenkins",
        password: "terrible_password1"
      })

    result =
      session_conn()
      |> put_session(:current_user, user.id)
      |> post_query(@join_group_mutation, %{
        "id" => 1
      })
      |> json_response(200)
      |> atomize_response()

    assert result == %{
             data: %{
               joinGroup: %{
                 group: %{id: "1", name: "Bodéwadmimwen"},
                 isAdmin: false,
                 isBanned: false,
                 isPending: true
               }
             }
           }

    user_id = user.id

    successfully_saved =
      %Group{id: 1}
      |> Languages.get_group_users()
      |> Enum.any?(fn x ->
        case x do
          %{user_id: ^user_id, group_id: 1} -> true
          _ -> false
        end
      end)

    assert successfully_saved
  end
end
