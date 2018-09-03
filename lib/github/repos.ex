defmodule Github.Repos do
  import Github.Client

  @moduledoc """
    [Repositories](https://developer.github.com/v3/repos/).
  """

  @doc """
  Get a repository

  ## Example

      iex> client = %Github.Client{access_token: "access_token"}

      iex> client |> Github.Repos.find!("WorkflowCI/github")
      %Github.Client.Response{
        body: %{"name" => "github", ...},
        status: 200,
        ...
      }
  """
  def find!(github_client, repo_path) do
    get!(
      "https://api.github.com/repos/#{repo_path}",
      [{"Authorization", "token #{github_client.access_token}"}]
    )
  end
end
