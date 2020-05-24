defmodule ZheshmowenWeb.UserMutationsTest do
  use ZheshmowenWeb.ConnCase
  alias Zheshmowen.{Accounts, Accounts.Guardian, Languages, Languages.Group}

  @sign_up_mutation """
  mutation signUp($name: String!, $email: String!, $password: String!) {
    signUp(name: $name, email: $email, password: $password) {
      token
    }
  }
  """

  test "mutation: sign_up", %{conn: conn} do
    result =
      conn
      |> post_query(@sign_up_mutation, %{
        "name" => "brub",
        "email" => "brub@test.com",
        "password" => "sick_password!"
      })
      |> json_response(200)
      |> atomize_response()

    %{data: %{signUp: %{token: token}}} = result
    {:ok, %{"sub" => id}} = Guardian.decode_and_verify(token)
    %{email: "brub@test.com"} = Accounts.get_user(id)
  end

  test "mutation: sign_up with bad arguments", %{conn: conn} do
    result =
      conn
      |> post_query(@sign_up_mutation, %{})
      |> json_response(200)
      |> atomize_response()

    %{
      errors: [
        %{
          message: ~s(In argument "name": Expected type "String!", found null.)
        },
        %{
          message: ~s(In argument "email": Expected type "String!", found null.)
        },
        %{
          message: ~s(In argument "password": Expected type "String!", found null.)
        },
        %{
          message: ~s(Variable "name": Expected non-null, found null.)
        },
        %{
          message: ~s(Variable "email": Expected non-null, found null.)
        },
        %{
          message: ~s(Variable "password": Expected non-null, found null.)
        }
      ]
    } = result
  end

  @join_group_mutation """
  mutation JoinGroup($id: ID, $is_admin: Boolean) {
    joinGroup(group: {id: $id, is_admin: $is_admin}) {
      isAdmin
      group {
        name
        id
      }
    }
  }
  """

  test "mutation: join_group", %{conn: conn} do
    {:ok, user} =
      Accounts.create_user(%{
        email: "jenkins@test.com",
        name: "jenkins",
        password: "terrible_password1"
      })

    {:ok, token, _} = Guardian.encode_and_sign(user)

    result =
      conn
      |> put_req_header("authorization", "Bearer #{token}")
      |> post_query(@join_group_mutation, %{
        "id" => 1,
        "is_admin" => false
      })
      |> json_response(200)
      |> atomize_response()

    assert result == %{
             data: %{joinGroup: %{group: %{id: "1", name: "Bodéwadmimwen"}, isAdmin: false}}
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
