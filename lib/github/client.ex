defmodule Github.Client do
  @moduledoc """
    Struct which represents GitHub client
  """

  @link_url_regex ~r/<(?<url>[^>]+)/
  @link_page_regex ~r/\bpage=(?<page>\d+)/

  defstruct [:access_token, :jwt_token]

  def to_json!(map) do
    Poison.encode!(map)
  end

  def from_json!(map) do
    Poison.decode!(map)
  end

  def post!(url, body, headers) do
    request = %{url: url, body: body, headers: headers}
    response = HTTPoison.post!(url, body, headers)

    %Github.Client.Response{
      request: request,
      body: from_json!(response.body),
      headers: response.headers,
      status: response.status_code
    }
  end

  def get!(url, headers) do
    request = %{url: url, headers: headers}
    response = HTTPoison.get!(url, headers)
    next_link_header = next_link_header(response)
    last_link_header = last_link_header(response)

    %Github.Client.Response{
      request: request,
      body: from_json!(response.body),
      headers: response.headers,
      status: response.status_code,
      next_url: link_url(next_link_header),
      last_url: link_url(last_link_header),
      next_page: link_page(next_link_header),
      last_page: link_page(last_link_header),
    }
  end

  def fetch_more!(github_response) do
    case github_response.next_url do
      nil -> nil
      url -> get!(url, github_response.request.headers)
    end
  end

  def fetch_all!(github_response) do
    fetch_all!(github_response, []) |> Enum.reverse
  end

  defp fetch_all!(github_response, acc) do
    github_response = fetch_more!(github_response)

    case github_response do
      nil -> acc
      _ -> fetch_all!(github_response, [github_response | acc])
    end
  end

  defp next_link_header(response) do
    link_header = Enum.find(response.headers, fn({header, _value}) -> header == "Link" end)

    case link_header do
      nil ->
        nil
      {_, link_value} ->
        link_value |> String.split(", ") |> Enum.find(fn(link) -> link =~ "rel=\"next\"" end)
    end
  end

  defp last_link_header(response) do
    link_header = Enum.find(response.headers, fn({header, _value}) -> header == "Link" end)

    case link_header do
      nil -> nil
      {_, link_value} -> link_value |> String.split(", ") |> Enum.find(& &1 =~ "rel=\"last\"")
    end
  end

  defp link_url(link_header) do
    case link_header do
      nil -> nil
      _ -> Regex.named_captures(@link_url_regex, link_header) |> Map.get("url")
    end
  end

  defp link_page(link_header) do
    case link_header do
      nil -> nil
      _ -> Regex.named_captures(@link_page_regex, link_header) |> Map.get("page")
    end
  end
end
