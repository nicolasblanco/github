defmodule Github.Git.Refs do
  import Github.Client

  @find_default_options %{
    branch: "master"
  }

  @moduledoc """
    Git Data [References](https://developer.github.com/v3/git/refs/).
  """

  @doc """
  User emails

  ## Example

      iex> client = %Github.Client{access_token: "access_token"}

      iex> client |> Github.Git.Refs.find!(
        repo_path: "WorkflowCI/github",
        branch: "master"
      )
      %Github.Client.Response{
        body: [%{"ref" => "refs/heads/master", ...}],
        status: 200,
        ...
      }
  """
  def find!(github_client, options) do
    opts = Enum.into(options, @find_default_options)

    get!(
      "https://api.github.com/repos/#{opts.repo_path}/git/refs/heads/#{opts.branch}",
      [{"Authorization", "token #{github_client.access_token}"}]
    )
  end
end
