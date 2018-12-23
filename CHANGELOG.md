# Changelog

The following are lists of the notable changes included with each release.
This is intended to help keep people informed about notable changes between
versions, as well as provide a rough history. Each item is prefixed with
one of the following labels: `Added`, `Changed`, `Deprecated`,
`Removed`, `Fixed`, `Security`. We also use [Semantic Versioning](http://semver.org)
to manage the versions of this gem so
that you can set version constraints properly.

#### [Unreleased](https://github.com/WorkflowCI/github/compare/v0.12.0-rc1...HEAD)

* WIP

#### [v0.12.0-rc1](https://github.com/WorkflowCI/github/compare/v0.12.0-rc1...v0.11.0) – 2018-12-22

* `Changed`: Switch from `poison` to `jason`, make it optional.
* `Changed`: `Joken` dependency version from 1.x to 2.x.
* `Changed`: Run tests asynchronously.
* `Added`: Enforce `mix format`.

#### [v0.11.0](https://github.com/WorkflowCI/github/compare/v0.10.0...v0.11.0) – 2018-12-22

* `Added`: [Github.Oauth2.Client](https://hexdocs.pm/github/Github.Oauth2.Client.html).
* `Added`: [Github.Users](https://hexdocs.pm/github/Github.Users.html).

#### [v0.10.0](https://github.com/WorkflowCI/github/compare/v0.9.0...v0.10.0) – 2018-09-04

* `Added`: [Github.Apps](https://hexdocs.pm/github/Github.Apps.html).

#### [v0.9.0](https://github.com/WorkflowCI/github/compare/v0.8.0...v0.9.0) – 2018-09-02

* `Added`: [Github.Pulls](https://hexdocs.pm/github/Github.Pulls.html).
* `Added`: [Github.Apps.Installations.find!](https://hexdocs.pm/github/Github.Apps.Installations.html#find!/2).
* `Added`: [Github.Client.generate_jwt_token](https://hexdocs.pm/github/Github.Client.html#generate_jwt_token/1).

#### [v0.8.0](https://github.com/WorkflowCI/github/compare/v0.7.0...v0.8.0) – 2018-09-02

* `Added`: [Github.Repos.Commits](https://hexdocs.pm/github/Github.Repos.Commits.html).
* `Added`: [Github.Repos.find!](https://hexdocs.pm/github/Github.Repos.html#find!/2).

#### [v0.7.0](https://github.com/WorkflowCI/github/compare/v0.6.0...v0.7.0) – 2018-08-31

* `Added`: [Github.Repos.Contents](https://hexdocs.pm/github/Github.Repos.Contents.html).
* `Added`: [Github.Git.Refs](https://hexdocs.pm/github/Github.Git.Refs.html).

#### [v0.6.0](https://github.com/WorkflowCI/github/compare/v0.5.0...v0.6.0) – 2018-08-31

* `Added`: [Github.Client.fetch_all!](https://hexdocs.pm/github/Github.Client.html#fetch_all!/1).
* `Added`: [Github.Client.fetch_more!](https://hexdocs.pm/github/Github.Client.html#fetch_more!/1).
* `Added`: more code examples.

#### [v0.5.0](https://github.com/WorkflowCI/github/compare/v0.4.0...v0.5.0) – 2018-08-31

* `Added`: [Github.Apps.Installations](https://hexdocs.pm/github/Github.Apps.Installations.html).
* `Added`: [Github.Client](https://hexdocs.pm/github/Github.Client.html).
* `Added`: pagination.

#### [v0.4.0](https://github.com/WorkflowCI/github/compare/v0.3.0...v0.4.0) – 2018-08-31

* `Added`: [Github.Orgs.find!](https://hexdocs.pm/github/Github.Orgs.html#find!/2).
* `Added`: [Github.Client.Response](https://hexdocs.pm/github/Github.Client.Response.html).

#### [v0.3.0](https://github.com/WorkflowCI/github/compare/v0.2.0...v0.3.0) – 2018-08-30

* `Added`: [Github.Users.Emails](https://hexdocs.pm/github/Github.Users.Emails.html).

#### [v0.2.0](https://github.com/WorkflowCI/github/compare/v0.1.0...v0.2.0) – 2018-08-30

* `Added`: [Github.Orgs](https://hexdocs.pm/github/Github.Orgs.html).

#### [v0.1.0](https://github.com/WorkflowCI/github/commit/456368e9fafc3416787ff1275c281f6dad236280) – 2018-08-30

* `Added`: initial functional version with [Github.Repos.Statuses](https://hexdocs.pm/github/Github.Repos.Statuses.html).
