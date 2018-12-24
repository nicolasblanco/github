defmodule Github.Issues.Comments do
  import Github.Client

  @moduledoc """
    Issues [Comments](https://developer.github.com/v3/issues/comments/).
  """

  @doc """
  Create a comment

  ## Example

      iex> client = %Github.Client{access_token: "access_token"}

      iex> client |> Github.Issues.Comments.create!(
        repo_path: "WorkflowCI/github",
        issue_number: 1,
        body: "hello world"
      )
      %Github.Client.Response{
        body: %{"url" => "https://api.github.com/repos/WorkflowCI/github/issues/comments/449685608", ...},
        status: 201,
        ...
      }
  """
  def create!(github_client, options) do
    opts = Enum.into(options, %{})

    url = "https://api.github.com/repos/#{opts.repo_path}/issues/#{opts.issue_number}/comments"
    body = to_json!(%{body: opts.body})
    headers = [{"Authorization", "token #{github_client.access_token}"}]

    post!(url, headers, body)
  end
end
