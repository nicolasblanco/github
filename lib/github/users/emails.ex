defmodule Github.Users.Emails do
  import Github

  @list_default_options %{
    page: 1,
    per_page: 30
  }

  @doc """
  ## Example

      iex> %Github.Client{access_token: "access_token"} |> Github.Users.Emails.list!(page: 1, per_page: 30)
      %Github.Response{
        body: [%{"email" => "email@example.com", "primary" => true, "verified" => true, "visibility" => "private"}],
        status: 200,
        headers: [...]
      }
  """
  def list!(github_client, options \\ []) do
    opts = Enum.into(options, @list_default_options)

    get!(
      "https://api.github.com/user/emails?page=#{opts.page}&per_page=#{opts.per_page}",
      [{"Authorization", "token #{github_client.access_token}"}]
    ) |> to_github_response(github_client)
  end
end
