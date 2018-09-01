defmodule Github.Repos.Contents do
  import Github.Client

  @find_default_options %{
    ref: "master"
  }

  @doc """
  Get the contents of a file or directory in a repository

  ## Example

      iex> client = %Github.Client{access_token: "access_token"}

      iex> client |> Github.Repos.Contents.find!(
        repo_path: "WorkflowCI/github",
        path: "README.md",
        ref: "master"
      )
      %Github.Client.Response{
        body: %{"path" => "README.md", ...},
        status: 200,
        ...
      }
  """
  def find!(github_client, options \\ []) do
    opts = Enum.into(options, @find_default_options)

    get!(
      "https://api.github.com/repos/#{opts.repo_path}/contents/#{opts.path}?ref=#{opts.ref}",
      [{"Authorization", "token #{github_client.access_token}"}]
    )
  end
end
