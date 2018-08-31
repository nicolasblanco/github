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
      %{
        "avatar_url" => "https://avatars0.githubusercontent.com/u/41810520?v=4",
        "context" => "WorkflowCI",
        "created_at" => "2018-08-31T00:48:43Z",
        ...
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

    response = post!(url, body, headers)

    from_json!(response.body)
  end
end
