defmodule Github do
  @moduledoc """
    The simplest client for GitHub [REST API v3](https://developer.github.com/v3/).

    Resources:

    * Repositories
      * [Statuses](/github/Github.Repos.Statuses.html)
  """

  def to_json!(map) do
    Poison.encode!(map)
  end

  def from_json!(map) do
    Poison.decode!(map)
  end

  def post!(url, body, headers) do
    HTTPoison.post!(url, body, headers)
  end
end
