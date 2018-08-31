defmodule Github.Users.Emails do
  import Github

  @doc """
  ## Example

      iex> Github.Users.Emails.list!("access_token")
      [
        %{
          "email" => "email@example.com",
          "primary" => true,
          "verified" => true,
          "visibility" => "private"
        }
      ]
  """

  def list!(access_token) do
    response = get!(
      "https://api.github.com/user/emails",
      [{"Authorization", "token #{access_token}"}]
    )

    from_json!(response.body)
  end
end
