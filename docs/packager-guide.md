---
title: Packager guide
---

## How apps are versioned

We simply take the version of the packaged app to be the same as the version of
the main `app` service in the `compose.yml` file. So, if you are deploying
`gitea/gitea:1.13.4` then the version of your Gitea app package version is
`1.13.4`.

However, most apps have underlying services like databases. When a new version
is published and available in the `compose.yml` but then `app` service version
has not changed, then we are using a `<version>~<revision>` syntax. So, if you
are still on `1.13.4` for Gitea but you have `mariadb:10.6` upgraded from
`mariadb:10.5` then the Gitea app package version would be `1.13.4~1`.
