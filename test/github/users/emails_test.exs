defmodule Github.Users.EmailsTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  test "returns a list" do
    use_cassette "users/emails.list!" do
      result = Github.Users.Emails.list!("access_token")
      assert result == [
        %{"email" => "email1@example.com", "primary" => true, "verified" => true, "visibility" => "private"},
        %{"email" => "email2@example.com", "primary" => false, "verified" => true, "visibility" => nil}
      ]
    end
  end
end
