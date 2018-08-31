defmodule Github.Orgs do
  import Github

  @doc """
  ## Example

      iex> Github.Orgs.user_list!("access_token")
      []
  """

  def user_list!(access_token) do
    response = get!(
      "https://api.github.com/user/orgs",
      [{"Authorization", "token #{access_token}"}]
    )

    from_json!(response.body)
  end
end
