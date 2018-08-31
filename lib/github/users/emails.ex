defmodule Github.Users.Emails do
  import Github

  @list_default_options %{
    page: 1,
    per_page: 30
  }

  @doc """
  ## Example

      iex> Github.Users.Emails.list!("access_token", page: 1, per_page: 30)
      %Github.Response{
        body: [%{"email" => "email@example.com", "primary" => true, "verified" => true, "visibility" => "private"}],
        status: 200,
        headers: [...]
      }
  """
  def list!(access_token, options \\ []) do
    opts = Enum.into(options, @list_default_options)

    get!(
      "https://api.github.com/user/emails?page=#{opts.page}&per_page=#{opts.per_page}",
      [{"Authorization", "token #{access_token}"}]
    ) |> to_github_response
  end
end
