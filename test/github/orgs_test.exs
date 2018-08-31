defmodule Github.OrgsTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  test "returns a list for current user" do
    use_cassette "orgs.user_list!" do
      response = Github.Orgs.user_list!("access_token")

      assert response.status == 200
      assert response.body == []
    end
  end
end
