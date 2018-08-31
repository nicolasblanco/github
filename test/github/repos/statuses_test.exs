defmodule Github.Repos.StatusesTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  test "creates the status" do
    use_cassette "repos/statuses.create!" do
      response = Github.Repos.Statuses.create!(
        "access_token",
        repo_path: "tester003/test",
        sha: "28e85be9a17c94056fde437c11a60069dfc41924",
        state: "success",
        target_url: "https://www.workflowci.com",
        description: "It is green, yay!",
        context: "WorkflowCI"
      )

      assert response.status == 201
      assert response.body["state"] == "success"
      assert response.body["target_url"] == "https://www.workflowci.com"
      assert response.body["description"] == "It is green, yay!"
      assert response.body["context"] == "WorkflowCI"
    end
  end
end
