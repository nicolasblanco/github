defmodule Github.Oauth2.ClientTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  test "generates authorize_url!" do
    result = Github.Oauth2.Client.authorize_url!(
      config: [client_id: "client_id", client_secret: "client_secret"],
      scope: "user:email"
    )

    assert result == "https://github.com/login/oauth/authorize?client_id=client_id&redirect_uri=&response_type=code&scope=user%3Aemail"
  end
end
