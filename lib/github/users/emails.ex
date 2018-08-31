defmodule Github.Users.Emails do
  import Github

  @doc """
  ## Example

      iex> Github.Users.Emails.list!("access_token")
      %Github.Response{
        body: [%{"email" => "email@example.com", "primary" => true, "verified" => true, "visibility" => "private"}],
        status: 200,
        headers: [...]
      }
  """

  def list!(access_token) do
    get!(
      "https://api.github.com/user/emails",
      [{"Authorization", "token #{access_token}"}]
    ) |> to_github_response
  end
end
