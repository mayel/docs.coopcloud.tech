---
title: Packager guide
---

## Package your first application

Let's take as an example, [Matomo web analytics](https://matomo.org/).

- Tired: Write your own image and compose file
- Wired: Use someone else's image (& maybe compose file)
- Inspired: Upstream image, someone else's compose file
- On fire: Upstream compose file

I'm feeling lazy so, luckily for me, Matomo already has an example compose file in their repository! Let's download and edit it:

```
mkdir matomo && cd matomo
wget https://raw.githubusercontent.com/matomo-org/docker/master/.examples/apache/docker-compose.yml -O compose.yml
```

Open the `compose.yml` in your favourite editor and have a gander :swan: . There are a few things we're looking for -- full list to come -- but a few things we can immediately see are:

1. Let's bump the version to `3.8`, to make sure we can use all the latest swarm coolness
2. We load environment variables separately via [abra](/overview/#command-line-tool), so we'll strip out `env_file`.
3. The `/var/www/html` volume definition on L21 is a bit overzealous; it means a copy of Matomo will be stored separately per app instance, which is a waste of space in most cases. We'll narrow it down according to the documentation -- here, the developers have been nice enough to suggest `logs` and `config` volumes instead, which is a decent start
4. The MySQL passwords are sent as variables which is fine for basic use, but if we replace them with Docker secrets we can keep them out of our env files if we want to publish those more widely.
5. The MariaDB service doesn't need to be exposed to the internet, so we can define an `internal` network for it to communicate with Matomo.
6. Lastly, we want to use `deploy.labels` and remove the `ports:` definition, to tell Traefik to forward requests to Matomo based on hostname and generate an SSL certificate.

The resulting `compose.yml` is available [here](https://git.autonomic.zone/coop-cloud/matomo/src/branch/main/compose.yml).

Now, create an `.env` file (or call it anything else, but remember to specify the `-e` option for `abra`):

```
TYPE=matomo

DOMAIN=matomo.example.com
LETS_ENCRYPT_ENV=production

SECRET_DB_PASSWORD_VERSION=v1
SECRET_DB_ROOT_PASSWORD_VERSION=v1
```

Then, open the `DOMAIN` you configured (you might need to wait a while for Traefik to generate SSL certificates) to finish the set-up. Luckily, this container is (mostly) configurable via environment variables -- if we want to auto-generate the configuration we can use a `config` and / or a custom `entrypoint` (see [`coop-cloud/mediawiki`](https://git.autonomic.zone/coop-cloud/mediawiki) for examples of both).

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

Versions `1.14.1-rootless` and `1.14.1-rooless_1` differ only in their version
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

## Automation

### Upgrades

See [autonomic-cooperative/renovate-bot](https://git.autonomic.zone/autonomic-cooperative/renovate-bot).

### Releases

```
---
kind: pipeline
name: recipe release
steps:
  - name: release a new version
    image: decentral1se/drone-abra:latest
    settings:
      command: recipe YOURRECIPE release
      deploy_key:
        from_secret: abra_bot_deploy_key
```

### Failure notifications

```yaml
  - name: notify coopcloud-dev on failure
    image: plugins/matrix
    settings:
      homeserver: https://matrix.autonomic.zone
      roomid: "IFazIpLtxiScqbHqoa:autonomic.zone"
      userid: "@autono-bot:autonomic.zone"
      accesstoken:
        from_secret: autono_bot_access_token
    depends_on:
    - deployment
  when:
    status:
      - failure
```
