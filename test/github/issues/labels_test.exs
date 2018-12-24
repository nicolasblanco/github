defmodule Github.Issues.LabelsTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  describe "create!/2" do
    test "create a new comment" do
      use_cassette "issues/labels.create!" do
        response =
          %Github.Client{access_token: "access_token"}
          |> Github.Issues.Labels.create!(
            repo_path: "WorkflowCI/github",
            name: "stale",
            color: "FFA700",
            description: "Inactive"
          )

        assert response.status == 201
        assert response.body["name"] == "stale"
        assert response.body["color"] == "FFA700"
        assert response.body["description"] == "Inactive"
      end
    end
  end
end
