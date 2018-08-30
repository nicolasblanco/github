defmodule Github.Repos.StatusesTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  test "creates the status" do
    use_cassette "repos/statuses#create!" do
      %{
        "state" => state,
        "target_url" => target_url,
        "description" => description,
        "context" => context
      } = Github.Repos.Statuses.create!(
        "access_token",
        repo_path: "tester003/test",
        sha: "28e85be9a17c94056fde437c11a60069dfc41924",
        state: "success",
        target_url: "https://www.workflowci.com",
        description: "It is green, yay!",
        context: "WorkflowCI"
      )

      assert state == "success"
      assert target_url == "https://www.workflowci.com"
      assert description == "It is green, yay!"
      assert context == "WorkflowCI"
    end
  end
end
