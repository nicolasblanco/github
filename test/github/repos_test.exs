defmodule Github.ReposTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  describe "find!/2" do
    test "returns a repository" do
      use_cassette "repos.find!" do
        response =
          %Github.Client{access_token: "access_token"} |> Github.Repos.find!("WorkflowCI/github")

        assert response.status == 200
        assert response.body["name"] == "github"
      end
    end
  end
end
