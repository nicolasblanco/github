defmodule Github.Users.Emails do
  import Github.Client

  @list_default_options %{
    page: 1,
    per_page: 30
  }

  @moduledoc """
    Users [Emails](https://developer.github.com/v3/users/emails/).
  """

  @doc """
  User emails

  ## Example

      iex> client = %Github.Client{access_token: "access_token"}

      iex> client |> Github.Users.Emails.list!(page: 1, per_page: 30)
      %Github.Client.Response{
        body: [%{"email" => "email@example.com", "primary" => true, "verified" => true, "visibility" => "private"}],
        status: 200,
        ...
      }
  """
  def list!(github_client, options \\ []) do
    opts = Enum.into(options, @list_default_options)

    get!(
      "https://api.github.com/user/emails?page=#{opts.page}&per_page=#{opts.per_page}",
      [{"Authorization", "token #{github_client.access_token}"}]
    )
  end
end
