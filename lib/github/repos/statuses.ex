defmodule Github.Repos.Statuses do
  import Github.Client

  @create_default_options %{
    context: "default"
  }

  @moduledoc """
    Repositories [Statuses](https://developer.github.com/v3/repos/statuses/).
  """

  @doc """
  Create a status for a specific commit SHA

  ## Example

      iex> client = %Github.Client{access_token: "access_token"}

      iex> client |> Github.Repos.Statuses.create!(
        repo_path: "workflowci/github",
        sha: "sha",
        state: "success",
        target_url: "https://www.workflowci.com",
        description: "It is green, yay!",
        context: "WorkflowCI"
      )
      %Github.Client.Response{
        body: %{"context" => "WorkflowCI", ...},
        status: 201,
        ...
      }
  """
  def create!(github_client, options) do
    opts = Enum.into(options, @create_default_options)
    url = "https://api.github.com/repos/#{opts.repo_path}/statuses/#{opts.sha}"
    body = to_json!(%{
      state: opts.state,
      target_url: opts.target_url,
      description: opts.description,
      context: opts.context
    })
    headers = [
      {"Authorization", "token #{github_client.access_token}"},
      {"Accept", "application/vnd.github.howard-the-duck-preview+json"},
    ]

    post!(url, body, headers)
  end
end
