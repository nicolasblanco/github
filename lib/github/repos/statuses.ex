defmodule Github.Repos.Statuses do
  import Github

  @create_default_options %{
    context: "default"
  }

  @doc """
  ## Example

      iex> Github.Repos.Statuses.create!(
        "access_token",
        repo_path: "workflowci/github",
        sha: "sha",
        state: "success",
        target_url: "https://www.workflowci.com",
        description: "It is green, yay!",
        context: "WorkflowCI"
      )
      %Github.Response{
        body: %{"context" => "WorkflowCI", ...},
        status: 201,
        headers: [...]
      }
  """

  def create!(access_token, options \\ []) do
    opts = Enum.into(options, @create_default_options)
    url = "https://api.github.com/repos/#{opts.repo_path}/statuses/#{opts.sha}"
    body = to_json!(%{
      state: opts.state,
      target_url: opts.target_url,
      description: opts.description,
      context: opts.context
    })
    headers = [
      {"Authorization", "token #{access_token}"},
      {"Accept", "application/vnd.github.howard-the-duck-preview+json"},
    ]

    post!(url, body, headers) |> to_github_response
  end
end
