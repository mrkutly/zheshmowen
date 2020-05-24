defmodule Zheshmowen.UserTest do
  use Zheshmowen.DataCase
  alias Zheshmowen.Accounts

  test "authentication: users can log in" do
    assert {:ok, _user} = Accounts.authenticate_user("mark@test.com", "insecure_password1")
  end

  test "authentication: bad passwords fail" do
    assert {:error, :invalid_credentials} =
             Accounts.authenticate_user("mark@test.com", "not_the_password")
  end

  test "authentication: invalid emails fail" do
    assert {:error, :invalid_credentials} =
             Accounts.authenticate_user("mark@test.co", "insecure_password1")
  end
end
