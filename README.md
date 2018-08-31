# GitHub Elixir

[![Build Status](https://img.shields.io/travis/WorkflowCI/github.svg)](https://travis-ci.org/WorkflowCI/github)
[![Latest Version](https://img.shields.io/hexpm/v/github.svg)](https://hex.pm/packages/github)

The simplest client for GitHub [REST API v3](https://developer.github.com/v3/).

## Resources

* [Repositories](https://developer.github.com/v3/repos/)
  * [Statuses](https://developer.github.com/v3/repos/statuses/)

## Installation

The package can be installed by adding `github` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:github, "~> 0.1.0"}
  ]
end
```

## Testing

```
make install
make test
```
