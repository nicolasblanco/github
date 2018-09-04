defmodule Github.AppsTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  test "returns an organization" do
    use_cassette "apps.create_access_token!" do
      response = %Github.Client{jwt_token: "jwt_token"} |> Github.Apps.create_access_token!(241102)

      assert response.status == 201
      assert response.body["token"] == "v1.e4f498f111eb59dbcb1bf7148f4dc8c94e7d3372"
      assert response.body["expires_at"] == "2018-09-04T04:46:29Z"
    end
  end
end
