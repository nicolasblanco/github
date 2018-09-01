# GitHub

[![Build Status](https://img.shields.io/travis/WorkflowCI/github.svg)](https://travis-ci.org/WorkflowCI/github)
[![Coverage Status](https://coveralls.io/repos/github/WorkflowCI/github/badge.svg)](https://coveralls.io/github/WorkflowCI/github)
[![Latest Version](https://img.shields.io/hexpm/v/github.svg)](https://hex.pm/packages/github)

The simplest Elixir client for GitHub [REST API v3](https://developer.github.com/v3/).

## Contents

* [Usage](#usage)
  * [Pagination](#pagination)
* [API Resouces](#api-resources)
* [Installation](#installation)
* [Testing](#testing)

## Usage

`Github` library supports multiple [API Resouces](#api-resources). For example, `Github.Users.Emails.list!` allows getting user's emails:

```elixir
client = %Github.Client{access_token: "access_token"}

client |> Github.Users.Emails.list!()
%Github.Client.Response{
  status: 200,
  headers: [
    {"Server", "GitHub.com"},
    ...
  ],
  body: [
    %{"email" => "hello@workflowci.com", "primary" => true, "verified" => true, "visibility" => "public"},
    ...
  ],
  ...
}
```

### Pagination

For pagination, the client has such functions as `Github.Client.fetch_more!` and `Github.Client.fetch_all!`. Here is an example:

```elixir
client = %Github.Client{access_token: "access_token"}

first_page = client |> Github.Users.Emails.list!(page: 1, per_page: 1)
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

Github.Client.fetch_more!(first_page)
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

* Apps
  * [Installations](https://hexdocs.pm/github/Github.Apps.Installations.html)
* [Organizations](https://hexdocs.pm/github/Github.Orgs.html)
* Repositories
  * [Contents](https://hexdocs.pm/github/Github.Repos.Contents.html)
  * [Statuses](https://hexdocs.pm/github/Github.Repos.Statuses.html)
* Users
  * [Emails](https://hexdocs.pm/github/Github.Users.Emails.html)

## Installation

The package can be installed by adding `github` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:github, "~> 0.6.0"}
  ]
end
```

## Testing

```
mix deps.get
mix test
```
