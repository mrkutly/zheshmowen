defmodule ZheshmowenWeb.GroupQueriesTest do
  use ZheshmowenWeb.ConnCase

  @groups_query """
  query {
    groups {
      name
      id
    }
  }
  """

  @group_where_query """
  query($name: String, $id: ID) {
    groupWhere(name: $name, id: $id) {
      name
      id
    }
  }
  """

  @group_with_users_query """
  query($name: String, $id: ID) {
    groupWhere(name: $name, id: $id) {
      name
      id
      groupUsers {
        isAdmin
        user {
          name
          id
        }
      }
    }
  }
  """

  test "query: groups", %{conn: conn} do
    result =
      conn
      |> post_query(@groups_query)
      |> json_response(200)
      |> atomize_response()

    assert result == %{data: %{groups: [%{id: "1", name: "Bodéwadmimwen"}]}}
  end

  test "query: group_where with name arg", %{conn: conn} do
    result =
      conn
      |> post_query(@group_where_query, %{"name" => "Bodéwadmimwen"})
      |> json_response(200)
      |> atomize_response()

    assert result == %{data: %{groupWhere: %{id: "1", name: "Bodéwadmimwen"}}}
  end

  test "query: group_where with id arg", %{conn: conn} do
    result =
      conn
      |> post_query(@group_where_query, %{"id" => 1})
      |> json_response(200)
      |> atomize_response()

    assert result == %{data: %{groupWhere: %{id: "1", name: "Bodéwadmimwen"}}}
  end

  test "query: group_where with users", %{conn: conn} do
    result =
      conn
      |> post_query(@group_with_users_query, %{"id" => 1})
      |> json_response(200)
      |> atomize_response()

    expected = %{
      data: %{
        groupWhere: %{
          id: "1",
          name: "Bodéwadmimwen",
          groupUsers: [%{isAdmin: false, user: %{id: "1", name: "mark"}}]
        }
      }
    }

    assert result == expected
  end
end
