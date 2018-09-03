defmodule Github.ClientTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  test "returns pagination info" do
    use_cassette "client#pagination_1" do
      client = %Github.Client{access_token: "access_token"}
      response = Github.Apps.Installations.list_repos!(client, per_page: 1)

      assert length(response.body["repositories"]) == 1
      assert response.next_page == "2"
      assert response.last_page == "77"
      assert response.next_url == "https://api.github.com/installation/repositories?per_page=1&page=2"
      assert response.last_url == "https://api.github.com/installation/repositories?per_page=1&page=77"
    end
  end

  test "Github.Client.fetch_more! returns more results" do
    table = :ets.new(:test, [:set])
    client = %Github.Client{access_token: "access_token"}
    use_cassette "client#pagination_1" do
      :ets.insert(
        table,
        {"response1", Github.Apps.Installations.list_repos!(client, per_page: 1)}
      )
    end

    use_cassette "client.fetch_more!" do
      [{"response1", response1}] = :ets.lookup(table, "response1")
      response2 = Github.Client.fetch_more!(response1)

      assert response2.status == 200
      assert length(response2.body["repositories"]) == 1
    end
  end

  test "Github.Client.fetch_all! returns the rest of the results" do
    table = :ets.new(:test, [:set])
    client = %Github.Client{access_token: "access_token"}
    use_cassette "client#pagination_50" do
      :ets.insert(
        table,
        {"response1", Github.Apps.Installations.list_repos!(client, per_page: 50)}
      )
    end

    use_cassette "client.fetch_all!" do
      [{"response1", response1}] = :ets.lookup(table, "response1")
      responses = Github.Client.fetch_all!(response1)

      assert length(responses) == 1
      [response2] = responses
      assert response2.status == 200
      assert length(response2.body["repositories"]) == 27
    end
  end

  test "Github.Client.generate_jwt_token returns a JWT token" do
    result = Github.Client.generate_jwt_token(app_id: 12345, private_key_filepath: "test/fixtures/app.pem")

    assert String.starts_with?(result, "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.")
    assert String.length(result) == 443
  end
end
