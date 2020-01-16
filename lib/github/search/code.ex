defmodule Github.Search.Code do
  import Github.Client

  @moduledoc """
    Search [Issues](https://developer.github.com/v3/search/#search-issues).
  """

  @doc """
  List code

  ## Example

      iex> client = %Github.Client{access_token: "access_token"}

      iex> client |> Github.Search.Code.find!(
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
      "https://api.github.com/search/code?#{URI.encode_query(opts)}",
      [
        {"Authorization", "token #{github_client.access_token}"},
        {"Accept", "application/vnd.github.symmetra-preview+json"}
      ]
    )
  end
end
