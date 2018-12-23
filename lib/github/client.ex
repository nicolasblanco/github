defmodule Github.Client do
  @moduledoc """
    Struct which represents GitHub client
  """

  @link_url_regex ~r/<(?<url>[^>]+)/
  @link_page_regex ~r/\bpage=(?<page>\d+)/
  @generate_jwt_token_default_options %{
    expire_in_minutes: 10
  }

  defstruct [:access_token, :jwt_token]

  def to_json!(map) do
    json_library().encode!(map)
  end

  def from_json!(map) do
    json_library().decode!(map)
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
      last_page: link_page(last_link_header)
    }
  end

  @doc """
  The next paginated page

  ## Example

      iex> client = %Github.Client{access_token: "access_token"}
      iex> response1 = client |> Github.Apps.Installations.list_repos!(per_page: 1)
      %Github.Client.Response{
        next_url: "https://api.github.com/installation/repositories?per_page=1&page=2",
        last_url: "https://api.github.com/installation/repositories?per_page=1&page=77",
        status: 200,
        ...
      }

      iex> response2 = client.fetch_more!(response1)
      %Github.Client.Response{
        next_url: "https://api.github.com/installation/repositories?per_page=1&page=3",
        last_url: "https://api.github.com/installation/repositories?per_page=1&page=77",
        status: 200,
        ...
      }
  """
  def fetch_more!(github_response) do
    case github_response.next_url do
      nil -> nil
      url -> get!(url, github_response.request.headers)
    end
  end

  @doc """
  The rest of the paginated pages

  ## Example

      iex> client = %Github.Client{access_token: "access_token"}
      iex> response1 = client |> Github.Apps.Installations.list_repos!(per_page: 30)
      %Github.Client.Response{
        next_url: "https://api.github.com/installation/repositories?per_page=30&page=2",
        last_url: "https://api.github.com/installation/repositories?per_page=30&page=3",
        status: 200,
        ...
      }

      iex> responses = client.fetch_all!(response1)
      [
        %Github.Client.Response{
          next_url: "https://api.github.com/installation/repositories?per_page=30&page=3",
          last_url: "https://api.github.com/installation/repositories?per_page=30&page=3",
          status: 200,
          ...
        },
        %Github.Client.Response{
          next_url: nil,
          last_url: "https://api.github.com/installation/repositories?per_page=30&page=3",
          status: 200,
          ...
        }
      ]

  To reduce number of HTTP requests it is recommended to specify the largest `per_page` value `100` in the first request.
  """
  def fetch_all!(github_response) do
    github_response |> fetch_all!([]) |> Enum.reverse()
  end

  @doc """
  Generate GitHub [JWT token](https://developer.github.com/apps/building-github-apps/authenticating-with-github-apps/#jwt-payload) with App ID and private key

  ## Example

      iex> Github.Client.generate_jwt_token(id: 12345, private_key_filepath: "app.pem", expire_in_minutes: 10)
      "eyJhbGciOiJSU..."
  """
  def generate_jwt_token(options) do
    opts = Enum.into(options, @generate_jwt_token_default_options)
    pem = File.read!(opts.private_key_filepath)
    signer = Joken.Signer.create("RS256", %{"pem" => pem})

    %{
      default_exp: opts.expire_in_minutes * 60,
      iss: opts.app_id |> Integer.to_string()
    }
    |> Joken.Config.default_claims()
    |> Joken.generate_and_sign!(nil, signer)
  end

  defp json_library do
    Application.get_env(Github.Client, :json_library) || Jason
  end

  defp fetch_all!(github_response, acc) do
    github_response = fetch_more!(github_response)

    case github_response do
      nil -> acc
      _ -> fetch_all!(github_response, [github_response | acc])
    end
  end

  defp next_link_header(response) do
    link_header = Enum.find(response.headers, fn {header, _value} -> header == "Link" end)

    case link_header do
      nil ->
        nil

      {_, link_value} ->
        link_value |> String.split(", ") |> Enum.find(fn link -> link =~ "rel=\"next\"" end)
    end
  end

  defp last_link_header(response) do
    link_header = Enum.find(response.headers, fn {header, _value} -> header == "Link" end)

    case link_header do
      nil -> nil
      {_, link_value} -> link_value |> String.split(", ") |> Enum.find(&(&1 =~ "rel=\"last\""))
    end
  end

  defp link_url(link_header) do
    case link_header do
      nil -> nil
      _ -> @link_url_regex |> Regex.named_captures(link_header) |> Map.get("url")
    end
  end

  defp link_page(link_header) do
    case link_header do
      nil -> nil
      _ -> @link_page_regex |> Regex.named_captures(link_header) |> Map.get("page")
    end
  end
end
