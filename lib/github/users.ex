defmodule Github.Users do
  import Github.Client

  @moduledoc """
    [Users](https://developer.github.com/v3/users/).
  """

  @doc """
  Find the authenticated user

  ## Example

      iex> client = %Github.Client{access_token: "access_token"}

      iex> client |> Github.Users.find!()
      %Github.Client.Response{
        body: %{"login" => "WorkflowCI", ...},
        status: 200,
        ...
      }
  """
  def find!(github_client) do
    get!(
      "https://api.github.com/user",
      [{"Authorization", "token #{github_client.access_token}"}]
    )
  end
end
