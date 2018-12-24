defmodule Github.IssuesTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  describe "edit!/2" do
    test "edits a issue" do
      use_cassette "issues.edit!" do
        response =
          %Github.Client{access_token: "access_token"}
          |> Github.Issues.edit!(
            repo_path: "WorkflowCI/github",
            issue_number: 1,
            state: "closed"
          )

        assert response.status == 200
        assert response.body["state"] == "closed"
        assert response.body["url"] == "https://api.github.com/repos/WorkflowCI/github/issues/1"
      end
    end
  end
end
