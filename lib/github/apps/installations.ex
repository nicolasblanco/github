defmodule Github.Apps.Installations do
  import Github

  @list_repos_default_options %{
    page: 1,
    per_page: 30
  }

  @doc """
  ## Example

      iex> %Github.Client{access_token: "access_token"} |> Github.Apps.Installations.list_repos!(page: 1, per_page: 30)
      %Github.Response{
        body: [%{"email" => "email@example.com", "primary" => true, "verified" => true, "visibility" => "private"}],
        status: 200,
        headers: [...]
      }
  """
  def list_repos!(github_client, options \\ []) do
    opts = Enum.into(options, @list_repos_default_options)
    get!(
      "https://api.github.com/installation/repositories?per_page=#{opts.per_page}&page=#{opts.page}",
      [
        {"Authorization", "token #{github_client.access_token}"},
        {"Accept", "application/vnd.github.machine-man-preview+json"}
      ]
    ) |> to_github_response(github_client)
  end
end
