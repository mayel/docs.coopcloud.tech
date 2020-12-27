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

 - .. to get started, you create a **server**, e.g. a new VPS, including
   your local configuration to connect to it.
 - .. then you install an **app** like wordpress or nextcloud, which is made up of multiple **services**
 - .. and configure your app.

[traefik]: https://hub.docker.com/_/traefik?tab=tags
[mariadb]: https://hub.docker.com/_/mariadb?tab=tags
