defmodule Github.Search.IssuesTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  describe "list!/2" do
    test "returns a list of issues" do
      use_cassette "search/issues.list!" do
        response =
          %Github.Client{access_token: "access_token"}
          |> Github.Search.Issues.list!(
            q: "repo:workflowci/test type:pr is:open updated:>=2018-01-01"
          )

        assert response.status == 200

        assert response.body["total_count"] == 1

        assert response.body["items"] |> Enum.at(0) |> get_in(["pull_request", "url"]) ==
                 "https://api.github.com/repos/WorkflowCI/github/pulls/1"
      end
    end
  end
end
