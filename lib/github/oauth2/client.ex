defmodule Github.Oauth2.Client do
  use OAuth2.Strategy

  @moduledoc """
    Client for GitHub Oauth2
  """

  @default_config [
    strategy: Github.Oauth2.Client,
    site: "https://api.github.com",
    authorize_url: "https://github.com/login/oauth/authorize",
    token_url: "https://github.com/login/oauth/access_token"
  ]

  @doc """
  Generate authorize URL

  ## Example

      iex> authorize_url = Github.Oauth2.Client.authorize_url!(
        config: [client_id: "client_id", client_secret: "client_secret"],
        scope: "user:email"
      )
      "https://github.com/login/oauth/authorize?client_id=client_id&redirect_uri=&response_type=code&scope=user%3Aemail"
  """
  def authorize_url!(options) do
    opts = Enum.into(options, %{})
    OAuth2.Client.authorize_url!(client(opts.config), scope: opts.scope)
  end

  @doc """
  Get access token

  ## Example

      iex> Github.Oauth2.Client.access_token!(
        config: [client_id: "client_id", client_secret: "client_secret"],
        params: [code: code]
      )
      "accessToken"
  """
  def access_token!(options) do
    opts = Enum.into(options, %{})
    OAuth2.Client.get_token!(client(opts.config), opts.params).token.access_token
  end

  # Strategy Callbacks

  def authorize_url(client, params) do
    OAuth2.Strategy.AuthCode.authorize_url(client, params)
  end

  def get_token(client, params, headers) do
    client
    |> put_param(:client_secret, client.client_secret)
    |> put_header("accept", "application/json")
    |> OAuth2.Strategy.AuthCode.get_token(params, headers)
  end

  defp client(config) do
    @default_config
    |> Keyword.merge(config)
    |> OAuth2.Client.new()
  end
end
