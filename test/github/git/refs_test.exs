defmodule Github.Git.RefsTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  describe "find!/2" do
    test "finds the head ref" do
      use_cassette "git/refs.find!" do
        response =
          %Github.Client{access_token: "access_token"}
          |> Github.Git.Refs.find!(
            repo_path: "WorkflowCI/github",
            branch: "master"
          )

        assert response.status == 200

        assert get_in(response.body, ["object", "sha"]) ==
                 "28e85be9a17c94056fde437c11a60069dfc41924"
      end
    end
  end
end
