defmodule ZheshmowenWeb.GroupMutationsTest do
  use ZheshmowenWeb.ConnCase
  alias Zheshmowen.{Languages, Accounts}

  @create_group_mutation """
  mutation createGroup($name: String!) {
    createGroup(name: $name) {
      name
      id
    }
  }
  """

  test "mutation: create_group" do
    {:ok, user} =
      Accounts.create_user(%{
        email: "dorby@test.com",
        name: "dorby",
        password: "terrible_password1"
      })

    result =
      session_conn()
      |> put_session(:current_user, user.id)
      |> post_query(@create_group_mutation, %{"name" => "Anishinaabemowin"})
      |> json_response(200)
      |> atomize_response()

    %{data: %{createGroup: %{name: "Anishinaabemowin", id: id}}} = result
    %{name: "Anishinaabemowin"} = Languages.get_group(id)
  end

  test "mutation: create_group with bad arguments", %{conn: conn} do
    result =
      conn
      |> post_query(@create_group_mutation, %{})
      |> json_response(200)
      |> atomize_response()

    %{
      errors: [
        %{
          locations: [%{column: 15, line: 2}],
          message: ~s(In argument "name": Expected type "String!", found null.)
        },
        %{
          locations: [%{column: 22, line: 1}],
          message: ~s(Variable "name": Expected non-null, found null.)
        }
      ]
    } = result
  end
end
