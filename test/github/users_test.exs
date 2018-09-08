defmodule Github.UsersTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  test "returns an authenticated user" do
    use_cassette "users.find!" do
      response = %Github.Client{access_token: "access_token"} |> Github.Users.find!()

      assert response.status == 200
      assert response.body["login"] == "WorkflowCI"
    end
  end
end
