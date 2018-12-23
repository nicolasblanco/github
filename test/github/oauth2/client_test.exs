defmodule Github.Oauth2.ClientTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  describe "authorize_url!/1" do
    test "generates authorize url" do
      result =
        Github.Oauth2.Client.authorize_url!(
          config: [client_id: "client_id", client_secret: "client_secret"],
          scope: "user:email"
        )

      assert result ==
               "https://github.com/login/oauth/authorize?client_id=client_id&redirect_uri=&response_type=code&scope=user%3Aemail"
    end
  end

  describe "access_token!/1" do
    test "returns access token" do
      use_cassette "oauth2/client.access_token!" do
        result =
          Github.Oauth2.Client.access_token!(
            config: [client_id: "client_id", client_secret: "client_secret"],
            params: [code: "code"]
          )

        assert result == "v1.e4f498f111eb59dbcb1bf7148f4dc8c94e7d3372"
      end
    end
  end
end
