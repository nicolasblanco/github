defmodule Github.Client.Response do
  @moduledoc """
    Struct which represents GitHub API response
  """

  @enforce_keys [:request, :body, :headers, :status]
  defstruct [
    :request,
    :body,
    :headers,
    :status,
    :next_page,
    :last_page,
    :next_url,
    :last_url
  ]
end
