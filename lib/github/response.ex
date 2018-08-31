defmodule Github.Response do
  @moduledoc """
    Struct which represents GitHub API response
  """

  @enforce_keys [:body, :headers, :status, :github_client]
  defstruct [:body, :headers, :status, :github_client, :current_page, :next_page]
end
