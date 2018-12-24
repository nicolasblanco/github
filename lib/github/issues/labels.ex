defmodule Github.Issues.Labels do
  import Github.Client

  @moduledoc """
    Issues [Labels](https://developer.github.com/v3/issues/labels/).
  """

  @doc """
  Create a label

  ## Example

      iex> client = %Github.Client{access_token: "access_token"}

      iex> client |> Github.Issues.Labels.create!(
        repo_path: "WorkflowCI/github",
        name: "stale",
        color: "FFA700",
        description: "Inactive"
      )
      %Github.Client.Response{
        body: %{"name" => "stale", ...},
        status: 201,
        ...
      }
  """
  def create!(github_client, options) do
    opts = Enum.into(options, %{})
    url = "https://api.github.com/repos/#{opts.repo_path}/labels"

    body =
      to_json!(%{
        name: opts.name,
        color: opts.color,
        description: opts[:description]
      })

    headers = [
      {"Authorization", "token #{github_client.access_token}"},
      {"Accept", "application/vnd.github.symmetra-preview+json"}
    ]

    post!(url, headers, body)
  end

  @doc """
  Add labels to an issue

  ## Example

      iex> client = %Github.Client{access_token: "access_token"}

      iex> client |> Github.Issues.Labels.add_to_issue!(
        repo_path: "WorkflowCI/github",
        issue_number: 1,
        labels: ["stale"]
      )
      %Github.Client.Response{
        body: [%{"name" => "stale", ...}],
        status: 200,
        ...
      }
  """
  def add_to_issue!(github_client, options) do
    opts = Enum.into(options, %{})
    url = "https://api.github.com/repos/#{opts.repo_path}/issues/#{opts.issue_number}/labels"
    body = to_json!(%{labels: opts.labels})

    headers = [
      {"Authorization", "token #{github_client.access_token}"},
      {"Accept", "application/vnd.github.symmetra-preview+json"}
    ]

    post!(url, headers, body)
  end

  @doc """
  Remove a label from an issue

  ## Example

      iex> client = %Github.Client{access_token: "access_token"}

      iex> client |> Github.Issues.Labels.remove_from_issue!(
        repo_path: "WorkflowCI/github",
        issue_number: 1,
        name: "stale"
      )
      %Github.Client.Response{
        body: [],
        status: 200,
        ...
      }
  """
  def remove_from_issue!(github_client, options) do
    opts = Enum.into(options, %{})

    url =
      "https://api.github.com/repos/#{opts.repo_path}/issues/#{opts.issue_number}/labels/#{
        opts.name
      }"

    headers = [
      {"Authorization", "token #{github_client.access_token}"},
      {"Accept", "application/vnd.github.symmetra-preview+json"}
    ]

    delete!(url, headers)
  end
end
