defmodule Github do
  @moduledoc """
    The simplest Elixir client for GitHub [REST API v3](https://developer.github.com/v3/).

    Resources:

    * [Organizations](/github/Github.Orgs.html)
    * Repositories
      * [Statuses](/github/Github.Repos.Statuses.html)
    * Users
      * [Emails](/github/Github.Users.Emails.html)
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

  def get!(url, headers) do
    HTTPoison.get!(url, headers)
  end
end
