defmodule Github.Issues.LabelsTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  describe "create!/2" do
    test "creates a new comment" do
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

  describe "add_to_issue!/2" do
    test "adds labels to an issue" do
      use_cassette "issues/labels.add_to_issue!" do
        response =
          %Github.Client{access_token: "access_token"}
          |> Github.Issues.Labels.add_to_issue!(
            repo_path: "WorkflowCI/github",
            issue_number: 1,
            labels: ["stale"]
          )

        assert response.status == 200
        label = response.body |> Enum.at(0)
        assert label["name"] == "stale"
        assert label["color"] == "FFA700"
        assert label["description"] == "Inactive"
      end
    end
  end

  describe "remove_from_issue!/2" do
    test "removes a label from an issue" do
      use_cassette "issues/labels.remove_from_issue!" do
        response =
          %Github.Client{access_token: "access_token"}
          |> Github.Issues.Labels.remove_from_issue!(
            repo_path: "WorkflowCI/github",
            issue_number: 1,
            name: "stale"
          )

        assert response.status == 200
        assert response.body == []
      end
    end
  end
end
