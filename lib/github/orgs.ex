defmodule Github.Orgs do
  import Github

  @doc """
  ## Example

      iex> Github.Orgs.user_list!("access_token")
      %Github.Response{
        body: [%{"id" => 1234, ...}],
        status: 200,
        headers: [...]
      }
  """

  def user_list!(access_token) do
    get!(
      "https://api.github.com/user/orgs",
      [{"Authorization", "token #{access_token}"}]
    ) |> to_github_response
  end
end
