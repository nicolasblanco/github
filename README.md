# GitHub

[![Build Status](https://img.shields.io/travis/WorkflowCI/github.svg)](https://travis-ci.org/WorkflowCI/github)
[![Coverage Status](https://coveralls.io/repos/github/WorkflowCI/github/badge.svg)](https://coveralls.io/github/WorkflowCI/github)
[![Latest Version](https://img.shields.io/hexpm/v/github.svg)](https://hex.pm/packages/github)

The simplest Elixir client for GitHub [REST API v3](https://developer.github.com/v3/).

## Contents

* [Usage](#usage)
  * [With OAuth access token](#with-oauth-access-token)
  * [With App JWT token](#with-app-jwt-token)
  * [Pagination](#pagination)
* [API Resouces](#api-resources)
* [Installation](#installation)
* [Testing](#testing)

## Usage

### With OAuth access token

`Github` library supports multiple [API Resources](#api-resources).
For example, [Github.Users.Emails.list!](https://hexdocs.pm/github/Github.Users.Emails.html#list!/2) allows getting user's emails:

```elixir
iex> github_client = %Github.Client{access_token: "access_token"}

iex> github_client |> Github.Users.Emails.list!()
%Github.Client.Response{
  status: 200,
  headers: [{"Server", "GitHub.com"}, ...],
  body: [%{"email" => "hello@workflowci.com", "primary" => true, "verified" => true, "visibility" => "public"}, ...],
  ...
}
```

### With App JWT token

To authenticate with a GitHub App and make an API call by using a [JWT token](https://developer.github.com/apps/building-github-apps/authenticating-with-github-apps/):

```elixir
iex> jwt_token = Github.Client.generate_jwt_token(app_id: 12345, private_key_filepath: "app.pem")

iex> github_client = %Github.Client{jwt_token: "jwt_token"}

iex> github_client |> Github.Apps.Installations.find!(67890)
%Github.Client.Response{
  status: 200,
  headers: [...],
  body: %{"id" => 12345, ...},
  ...
}
```

### Pagination

For pagination, the client has such functions as [Github.Client.fetch_more!](https://hexdocs.pm/github/Github.Client.html#fetch_more!/1) and [Github.Client.fetch_all!](https://hexdocs.pm/github/Github.Client.html#fetch_all!/1). Here is an example:

```elixir
iex> github_client = %Github.Client{access_token: "access_token"}

iex> first_page = github_client |> Github.Users.Emails.list!(page: 1, per_page: 1)
%Github.Client.Response{
  status: 200,
  headers: [...],
  body: [...],
  next_page: 2,
  last_page: 3,
  next_url: "https://api.github.com/user/emails?page=2&per_page=1",
  last_url: "https://api.github.com/user/emails?page=3&per_page=1",
  ...
}

iex> Github.Client.fetch_more!(first_page)
%Github.Client.Response{
  status: 200,
  headers: [...],
  body: [...],
  next_page: 3,
  last_page: 3,
  next_url: "https://api.github.com/user/emails?page=3&per_page=1",
  last_url: "https://api.github.com/user/emails?page=3&per_page=1",
  ...
}
```

Please visit [hexdocs.pm/github](https://hexdocs.pm/github/api-reference.html) to find more code examples.

## API Resources

* [Apps](https://hexdocs.pm/github/Github.Apps.html)
  * [Installations](https://hexdocs.pm/github/Github.Apps.Installations.html)
* Git
  * [References](https://hexdocs.pm/github/Github.Git.Refs.html)
* [Organizations](https://hexdocs.pm/github/Github.Orgs.html)
* [Repositories](https://hexdocs.pm/github/Github.Repos.html)
  * [Commits](https://hexdocs.pm/github/Github.Repos.Commits.html)
  * [Contents](https://hexdocs.pm/github/Github.Repos.Contents.html)
  * [Statuses](https://hexdocs.pm/github/Github.Repos.Statuses.html)
* [Pull Requests](https://hexdocs.pm/github/Github.Pulls.html)
* Users
  * [Emails](https://hexdocs.pm/github/Github.Users.Emails.html)

## Installation

The package can be installed by adding `github` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:github, "~> 0.10.0"}
  ]
end
```

## Testing

```
mix deps.get
mix test
```
