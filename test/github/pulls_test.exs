defmodule Github.PullsTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  describe "list!/2" do
    test "returns a list of pull requests" do
      use_cassette "pulls.list!" do
        response =
          %Github.Client{access_token: "access_token"}
          |> Github.Pulls.list!(repo_path: "WorkflowCI/github")

        assert response.status == 200
        assert response.body |> Enum.at(0) |> Map.get("number") == 16
      end
    end
  end
end
