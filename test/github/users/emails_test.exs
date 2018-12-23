defmodule Github.Users.EmailsTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  describe "list!/2" do
    test "returns a list" do
      use_cassette "users/emails.list!" do
        response = %Github.Client{access_token: "access_token"} |> Github.Users.Emails.list!()

        assert response.status == 200

        assert response.body == [
                 %{
                   "email" => "email1@example.com",
                   "primary" => true,
                   "verified" => true,
                   "visibility" => "private"
                 },
                 %{
                   "email" => "email2@example.com",
                   "primary" => false,
                   "verified" => true,
                   "visibility" => nil
                 }
               ]
      end
    end
  end
end
