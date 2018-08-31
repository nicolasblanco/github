defmodule Github.Orgs do
  import Github

  @user_list_default_options %{
    page: 1,
    per_page: 30
  }

  @doc """
  ## Example

      iex> %Github.Client{access_token: "access_token"} |> Github.Orgs.user_list!(page: 1, per_page: 30)
      %Github.Response{
        body: [%{"name" => "WorkflowCI", ...}],
        status: 200,
        headers: [...]
      }
  """
  def user_list!(github_client, options \\ []) do
    opts = Enum.into(options, @user_list_default_options)

    get!(
      "https://api.github.com/user/orgs?page=#{opts.page}&per_page=#{opts.per_page}",
      [{"Authorization", "token #{github_client.access_token}"}]
    ) |> to_github_response(github_client)
  end

  @doc """
  ## Example

      iex> %Github.Client{access_token: "access_token"} |> Github.Orgs.find!("WorkflowCI")
      %Github.Response{
        body: [%{"name" => "WorkflowCI", ...}],
        status: 200,
        headers: [...]
      }
  """
  def find!(github_client, name) do
    get!(
      "https://api.github.com/orgs/#{name}",
      [{"Authorization", "token #{github_client.access_token}"}]
    ) |> to_github_response(github_client)
  end
end
