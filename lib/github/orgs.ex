defmodule Github.Orgs do
  import Github

  @user_list_default_options %{
    page: 1,
    per_page: 30
  }

  @doc """
  ## Example

      iex> Github.Orgs.user_list!("access_token", page: 1, per_page: 30)
      %Github.Response{
        body: [%{"name" => "WorkflowCI", ...}],
        status: 200,
        headers: [...]
      }
  """
  def user_list!(access_token, options \\ []) do
    opts = Enum.into(options, @user_list_default_options)

    get!(
      "https://api.github.com/user/orgs?page=#{opts.page}&per_page=#{opts.per_page}",
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
