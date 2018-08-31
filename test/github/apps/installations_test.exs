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
end
