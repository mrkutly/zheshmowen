defmodule ZheshmowenWeb.UserMutationsTest do
  use ZheshmowenWeb.ConnCase
  alias Zheshmowen.Accounts

  @sign_up_mutation """
  mutation signUp($name: String!, $email: String!) {
    signUp(name: $name, email: $email) {
      name
      email
      id
    }
  }
  """

  test "mutation: sign_up", %{conn: conn} do
    result =
      conn
      |> post_query(@sign_up_mutation, %{"name" => "brub", "email" => "brub@test.com"})
      |> json_response(200)
      |> atomize_response()

    %{data: %{signUp: %{name: "brub", email: "brub@test.com", id: id}}} = result
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
          locations: [%{column: 10, line: 2}],
          message: ~s(In argument "name": Expected type "String!", found null.)
        },
        %{
          locations: [%{column: 23, line: 2}],
          message: ~s(In argument "email": Expected type "String!", found null.)
        },
        %{
          locations: [%{column: 17, line: 1}],
          message: ~s(Variable "name": Expected non-null, found null.)
        },
        %{
          locations: [%{column: 33, line: 1}],
          message: ~s(Variable "email": Expected non-null, found null.)
        }
      ]
    } = result
  end
end
