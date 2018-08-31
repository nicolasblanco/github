defmodule Github.ClientTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  test "returns pagination info" do
    use_cassette "client#pagination" do
      client = %Github.Client{access_token: "access_token"}
      response = Github.Apps.Installations.list_repos!(client, per_page: 1)

      assert response.next_page == "2"
      assert response.last_page == "77"
      assert response.next_url == "https://api.github.com/installation/repositories?per_page=1&page=2"
      assert response.last_url == "https://api.github.com/installation/repositories?per_page=1&page=77"
    end
  end

  test "Github.Client.fetch_more! returns more results" do
    table = :ets.new(:buckets_registry, [:set, :protected])
    client = %Github.Client{access_token: "access_token"}

    use_cassette "client#pagination" do
      response1 = Github.Apps.Installations.list_repos!(client, per_page: 1)
      :ets.insert(table, {"response1", response1})
    end

    use_cassette "client.fetch_more!" do
      [{"response1", response1}] = :ets.lookup(table, "response1")
      response2 = Github.Client.fetch_more!(response1)

      assert response2.status == 200
      assert response2.body["repositories"] |> Enum.at(0) |> Map.get("name") == "github2"
    end
  end
end
