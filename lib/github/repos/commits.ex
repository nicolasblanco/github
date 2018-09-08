defmodule Github.Repos.Commits do
  import Github.Client

  @moduledoc """
    Repositories [Commits](https://developer.github.com/v3/repos/commits/).
  """

  @doc """
  Get a single commit

  ## Example

      iex> client = %Github.Client{access_token: "access_token"}

      iex> client |> Github.Repos.Commits.find!(
        repo_path: "workflowci/github",
        sha: "28e85be9a17c94056fde437c11a60069dfc41924"
      )
      %Github.Client.Response{
        body: %{"sha" => "28e85be9a17c94056fde437c11a60069dfc41924", ...},
        status: 200,
        ...
      }
  """
  def find!(github_client, options) do
    opts = Enum.into(options, %{})

    get!(
      "https://api.github.com/repos/#{opts.repo_path}/commits/#{opts.sha}",
      [{"Authorization", "token #{github_client.access_token}"}]
    )
  end
end
