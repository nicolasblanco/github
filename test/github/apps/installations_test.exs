defmodule Github.Apps.InstallationsTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  test "returns a list of repos" do
    use_cassette "apps/installations.list_repos!" do
      response = %Github.Client{access_token: "access_token"} |> Github.Apps.Installations.list_repos!()

      assert response.status == 200
      assert response.body["repositories"] |> Enum.at(0) |> Map.get("name") == "github"
    end
  end

  test "returns an installation" do
    use_cassette "apps/installations.find!" do
      response = %Github.Client{jwt_token: "jwt_token"} |> Github.Apps.Installations.find!(241102)

      assert response.status == 200
      assert response.body["id"] == 241102
    end
  end
end
