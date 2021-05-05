---
title: Packager guide
---

## How apps are versioned

We simply take the version of the packaged app to be the same as the version of
the main `app` service in the `compose.yml` file. So, if you are deploying
`gitea/gitea:1.13.4` then the version of your Gitea app package version is
`1.13.4`.

Additionally, most apps have underlying services like databases and/or caches.
When a new version is published and available in the `compose.yml` we use the
`<version>_<revision>` syntax. So, if you are still on `1.13.4` for Gitea but
you have `mariadb:10.6` upgraded from `mariadb:10.5` then the Gitea app package
version would be `1.13.4_1`.

Our high level goals of app versioning on this project are not to invent a new
versioning system. Therefore, we try to follow the upstream versioning as much
as possible. This scheme is still a work in progress.
