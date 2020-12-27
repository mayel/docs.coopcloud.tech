---
title: Welcome
---

Coöp Cloud (working title; abbreviated CoCl) is a container-based, platform-agnostic, free software registry for small service providers.

 - Production-ready apps in minutes: Wordpress & Nextcloud instances,
   mail-servers, and more.
 - Simple Docker-based framework for continuous deployment of your custom apps.

[List of CoCl apps](https://codimd.autonomic.zone/s/HyNtOhwrv){: .md-button }

HOWTOs:

 - [Deploy an HTML site](howto/html-website.md)
 - [CoCl-ise an app](howto/convert-app.md)

!!! warning "A note about ARM"
    Not all applications currently support all ARM computers (like PINE64 and
    Raspberry Pi): e.g. [Traefik will work on ARMv6 & ARM64][traefik], [the
    official MariaDB app doesn't work on any ARM boards][mariadb]. It might be possible
    to use third-party ARM images with separate `compose.yml` files, but we
    haven't exlplored this rabbit-hole much yet.

## Definitions

CoCl is a **philosophy**.

 - To get started, you create a **server**, e.g. a new VPS, including
   your local configuration to connect to it...
 - then you install an **app** like wordpress or nextcloud, which is made up of multiple **services**...
 - .. and configure your app.

## Technical description

Software-wise, CoöpCloud is:

 - [`coop-cloud`](https://git.autonomic.zone/coop-cloud/), a collection of Docker "swarm mode" configurations for popular web apps
 - [`abra`](https://git.autonomic.zone/autonomic-cooperative/abra), a simple tool for Docker swarm management
 - a recommended default set of stacks:
    - Traefik for SSL & routing
    - `postfix-relay` for outgoing email

## Principles / features:

 - Security by default
     - Secret storage using `docker secret` (["What makes it secure?"](https://github.com/BretFisher/ama/issues/86))
     - Automatic SSL using Traefik & LetsEncrypt
 - Zero-downtime deployments (for apps with healthchecks defined)
 - Continuous integration testing using Drone and our [`stack-ssh-deploy`](https://git.autonomic.zone/coop-cloud/stack-ssh-deploy) plugin
 - Low maintenance overhead:
     - Automatic tracking of upstream Docker images using `renovate-bot`
     - Avoiding custom Docker images as far as possible

[traefik]: https://hub.docker.com/_/traefik?tab=tags
[mariadb]: https://hub.docker.com/_/mariadb?tab=tags
