defmodule ZheshmowenWeb.UserQueriesTest do
  use ZheshmowenWeb.ConnCase

  @user_where_query """
  query($email: String, $id: ID) {
    userWhere(email: $email, id: $id) {
      email
      name
      id
    }
  }
  """

  @user_where_with_groups """
  query($email: String, $id: ID) {
    userWhere(email: $email, id: $id) {
      name
      email
      id
      userGroups {
        isAdmin
        group {
          name
          id
        }
      }
    }
  }
  """

  test "query: user_where with email arg", %{conn: conn} do
    result =
      conn
      |> post_query(@user_where_query, %{"email" => "mark@test.com"})
      |> json_response(200)
      |> atomize_response()

    assert result == %{data: %{userWhere: %{id: "1", name: "mark", email: "mark@test.com"}}}
  end

  test "query: user_where with id arg", %{conn: conn} do
    result =
      conn
      |> post_query(@user_where_query, %{"id" => 1})
      |> json_response(200)
      |> atomize_response()

    assert result == %{data: %{userWhere: %{id: "1", name: "mark", email: "mark@test.com"}}}
  end

  test "query: user_where with user_groups", %{conn: conn} do
    result =
      conn
      |> post_query(@user_where_with_groups, %{"id" => 1})
      |> json_response(200)
      |> atomize_response()

    expected = %{
      data: %{
        userWhere: %{
          email: "mark@test.com",
          id: "1",
          name: "mark",
          userGroups: [%{group: %{id: "1", name: "Bodéwadmimwen"}, isAdmin: false}]
        }
      }
    }

    assert result == expected
  end
end
