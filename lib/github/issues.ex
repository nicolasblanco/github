defmodule Github.Issues do
  import Github.Client

  @moduledoc """
    [Issues](https://developer.github.com/v3/issues/).
  """

  @doc """
  Edit an issue

  ## Example

      iex> client = %Github.Client{access_token: "access_token"}

      iex> client |> Github.Issues.edit!(
        repo_path: "WorkflowCI/github",
        issue_number: 1,
        state: "closed"
      )
      %Github.Client.Response{
        body: %{"url" => "https://api.github.com/repos/WorkflowCI/github/issues/1", ...},
        status: 200,
        ...
      }
  """
  def edit!(github_client, options) do
    opts =
      options
      |> Enum.filter(fn {_, v} -> v end)
      |> Enum.into(%{})

    url = "https://api.github.com/repos/#{opts.repo_path}/issues/#{opts.issue_number}"

    headers = [
      {"Authorization", "token #{github_client.access_token}"},
      {"Accept", "application/vnd.github.symmetra-preview+json"}
    ]

    body =
      to_json!(
        opts
        |> Map.take([:title, :body, :state, :milestone, :labels, :assignees])
      )

    patch!(url, headers, body)
  end
end
