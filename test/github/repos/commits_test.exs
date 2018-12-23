defmodule Github.Repos.CommitsTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  describe "find!/2" do
    test "returns commit info" do
      use_cassette "repos/commits.find!" do
        response =
          %Github.Client{access_token: "access_token"}
          |> Github.Repos.Commits.find!(
            repo_path: "WorkflowCI/github",
            sha: "28e85be9a17c94056fde437c11a60069dfc41924"
          )

        assert response.status == 200
        assert response.body["sha"] == "28e85be9a17c94056fde437c11a60069dfc41924"
      end
    end
  end
end
