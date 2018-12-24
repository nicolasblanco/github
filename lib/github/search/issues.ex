defmodule Github.Search.Issues do
  import Github.Client

  @moduledoc """
    Search [Issues](https://developer.github.com/v3/search/#search-issues).
  """

  @doc """
  List issues

  ## Example

      iex> client = %Github.Client{access_token: "access_token"}

      iex> client |> Github.Search.Issues.find!(
        q: "repo:WorkflowCI/github type:pr is:open updated:>=2018-01-01"
      )
      %Github.Client.Response{
        body: %{"total_count" => 1, ...},
        status: 200,
        ...
      }
  """
  def list!(github_client, options) do
    opts = Enum.into(options, %{})

    get!(
      "https://api.github.com/search/issues?#{URI.encode_query(opts)}",
      [
        {"Authorization", "token #{github_client.access_token}"},
        {"Accept", "application/vnd.github.symmetra-preview+json"}
      ]
    )
  end
end
