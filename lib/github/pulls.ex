defmodule Github.Pulls do
  import Github.Client

  @list_default_options %{
    state: "open",
    page: 1,
    per_page: 30
  }

  @moduledoc """
    [Pull Requests](https://developer.github.com/v3/pulls/).
  """

  @doc """
  List pull requests

  ## Example

      iex> client = %Github.Client{access_token: "access_token"}

      iex> client |> Github.Pulls.list!(repo_path: "WorkflowCI/github", state: "open", per_page: 30, page: 1)
      %Github.Client.Response{
        body: [%{"number" => 10, ...}],
        status: 200,
        ...
      }
  """
  def list!(github_client, options \\ []) do
    opts = Enum.into(options, @list_default_options)

    get!(
      "https://api.github.com/repos/#{opts.repo_path}/pulls?state=#{opts.state}&per_page=#{opts.per_page}&page=#{opts.page}",
      [{"Authorization", "token #{github_client.access_token}"}]
    )
  end
end
