defmodule Github.OrgsTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  test "returns a list for current user" do
    use_cassette "orgs.user_list!" do
      result = Github.Orgs.user_list!("access_token")
      assert result == []
    end
  end
end
