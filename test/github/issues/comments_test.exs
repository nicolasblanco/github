defmodule Github.Issues.CommentsTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  describe "create!/2" do
    test "creates a new comment" do
      use_cassette "issues/comments.create!" do
        response =
          %Github.Client{access_token: "access_token"}
          |> Github.Issues.Comments.create!(
            repo_path: "WorkflowCI/github",
            issue_number: 1,
            body: "hello world"
          )

        assert response.status == 201
        assert response.body["body"] == "hello world"
        assert response.body["user"]["login"] == "workflowci[bot]"

        assert response.body["url"] ==
                 "https://api.github.com/repos/WorkflowCI/github/issues/comments/449685608"
      end
    end
  end
end
