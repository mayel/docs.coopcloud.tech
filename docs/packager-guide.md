---
title: Packager guide
---

## How apps are versioned

Co-op Cloud follows the version scheme of the applications we're packaging, as
far as possible; for example, [version `1.13.4` of our Gitea recipe][gitea]
contains version `1.13.4` of Gitea. We're trying not to invent a new versioning
scheme.

This approach is still work-in-progress.

Versions are based on [Docker image tags][tags]: we don't currently have a plan for apps
which only publish a `latest` or `master` tag, for instance.

### Versioning different services

Most apps have underlying services like databases and/or caches.

When there's a new version of one of these services, but not the "main" service,
we add/increment the `_<revision>` part at the end of the version.

So, if you are still on `1.13.4` for Gitea, but you have `mariadb:10.6` upgraded
from `mariadb:10.5`, then the Gitea recipe package version would be `1.13.4_1`.

If you run `abra recipe gitea versions`, you'll see that there are a few
available versions of the `gitea` recipe, two with the same version of the
`gitea` image:

```
1.14.1-rootless:
 - app (gitea/gitea:1.14.1-rootless, 6244e9fc)
 - db (mariadb:10.5, 36288c67)
1.14.1-rootless_1:
 - app (gitea/gitea:1.14.1-rootless, 6244e9fc)
 - db (mariadb:10.6, 718cb856)
1.14.2-rootless:
 - app (gitea/gitea:1.14.2-rootless, bedf8d12)
 - db (mariadb:10.6, 718cb856)
```

Versions `1.14.1-rootless` and `1.14.1-rooless_1`  differ only in their version
of the `mariadb` service. If there had been several updates to the `mariadb`
image in between updates to the `gitea` image, there might have also been
`1.14.1-rooless_2`, `1.14.1-rooless_3` -- this is more likely with recipes which
include services with several different images.

!!! note 

	Not all of these updates will be released as installable Co-op Cloud recipes
	-- in this example, there's no version with `gitea:1.14.2-rootless` and
	`mariadb:10.5`. If you need a specific combination, create a pull request or
	issue in the repository for the app recipe!

[gitea]: https://git.autonomic.zone/coop-cloud/gitea/src/tag/1.13.4
[tags]: https://docs.docker.com/engine/reference/commandline/tag/
