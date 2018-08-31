defmodule Github.Orgs do
  import Github

  @doc """
  ## Example

      iex> Github.Orgs.user_list!("access_token")
      %Github.Response{
        body: [%{"name" => "WorkflowCI", ...}],
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

  @doc """
  ## Example

      iex> Github.Orgs.find!("access_token", "WorkflowCI")
      %Github.Response{
        body: [%{"name" => "WorkflowCI", ...}],
        status: 200,
        headers: [...]
      }
  """
  def find!(access_token, name) do
    get!(
      "https://api.github.com/orgs/#{name}",
      [{"Authorization", "token #{access_token}"}]
    ) |> to_github_response
  end
end
