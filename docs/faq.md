---
title: Frequently asked questions
---

## What is the Co-op Cloud?

Co-op Cloud aims to make hosting libre software applications simple for small providers. It uses the latest container technologies and innovations and configurations are shared into [the commons](https://en.wikipedia.org/wiki/Commons) for the benefit of all. The project is intended for small service providers such as tech co-operatives who are looking to standardise around an open, transparent and scalable infrastructure.

## Who is behind the project?

The project was started by workers at [Autonomic](https://autonomic.zone/) which is a [workers co-operative](https://en.wikipedia.org/wiki/Worker_cooperative) providing technologies and infrastructure to empower users to make a positive impact on the world. We use Co-op Cloud in production amongst other systems.

## Why Co-op Cloud?

#### 👍

- 👍 Thin "ease of use" layer on top of already standardised tooling
- 👍 Extremely modular
- 👍 Collective commons based configuration via public git repos
- 👍 Focussed on hosting providers
- 👍 Uses upstream published containers (no duplication on packaging)
- 👍 Now and always libre software
- 👍 Command line focussed
- 👍 Horizontal and vertical scaling

#### 👎

- 👎 Still a very young project
- 👎 Limited availability of well tested apps
- 👎 Requires command line knowledge to use
- 👎 Currently x86 only

## Why start another project?

Please read our [initial project announcement post](https://autonomic.zone/blog/co-op-cloud/) for more on this.

## What about `$alternative`?

We have various technical critiques of other similar projects which are already
up-and-running in the ecosystem as they don't necessarily meet our needs as a small tech co-op. However, the Co-op Cloud isn't meant to be a replacement for these others projects. Here is a short overview of the pros/cons we see and how that relates to our goals here.

### Cloudron

#### 👍

- 👍 Decent web interface for application, domain & user management.
- 👍 Large library of applications.
- 👍 Built-in SSO using LDAP, which is compatible with more applications and often has a better user interface than OAuth.
- 👍 Applications are actively maintained by the Cloudron team.

#### 👎

- 👎 Moving away from open source. The core is now proprietary software.
- 👎 libre tier has a single application limit.
- 👎 Based on Docker images, not stacks, so multi-process applications (e.g. parsoid visual editor for Mediawiki) are a non-starter.
- 👎 Difficult to extend applications.
- 👎 Only supported on Ubuntu LTS.
- 👎 Upstreams libre software communities aren't involved in packaging.
- 👎 Limited to vertical scaling.
- 👎 Tension between needs of hosting provider and non-technical user.
- 👎 Bit of a [black box](https://en.wikipedia.org/wiki/Black_box).

### YunoHost

#### 👍

- 👍 Lovely web interface for application, domain & user management.
- 👍 Bigger library of applications.
- 👍 Awesome backup / deploy / restore continuous integration testing.
- 👍 Supports hosting applications in subdirectories as well as subdomains.
- 👍 Doesn't require a public-facing IP.
- 👍 Supports system-wide mutualisation of resources for apps (e.g. sharing databases by default)

#### 👎

- 👎 Upstream libre software communities aren't involved in packaging.
- 👎 Uninstalling applications leaves growing cruft.
- 👎 Limited to vertical scaling.
- 👎 Not intended for use by hosting providers.

### Ansible

#### 👍

- 👍 Includes server creation and bootstrapping.

#### 👎

- 👎 Upstream libre software communities aren't publishing Ansible roles
- 👎 Lots of manual work involved in things like app isolation, backups, updates

### Kubernetes

#### 👍

- 👍 Helm charts are available for some key apps already.
- 👍 Scale all the things.

#### 👎

- 👎 Too big -- requires 3rd party tools to run a single-node instance.
- 👎 Not suitable for a small to mid size hosting provider.

### Docker-compose

#### 👎

- 👎 Manual work required for process monitoring.
- 👎 Secret storage not available yet.
- 👎 [Swarm is the new best practice](https://github.com/BretFisher/ama/issues/8#issuecomment-367575011).

### Doing it Manually (Old School)

#### 👍

- 👍 Simple - just follow upstream instructions to install and update.

#### 👎

- 👎 Loads of manual work required for application isolation and backups.
- 👎 Array of sysadmin skills required to install and maintain applications.
- 👎 Hard to share configurations into the commons.
- 👎 No idea who has done what change when.

## Which technologies are used?

The core technologies of Co-op Cloud are libre software and enjoy wide adoption across software developer communities.

- [Containers](#why-containers)
- [Compose specification](#why-docker-compose)
- [Docker swarm](#why-docker-swarm)
- [Abra command-line tool](https://git.autonomic.zone/coop-cloud/abra)

## Why containers?

We use containers because so many libre software communities choose to use them! They are already writing and using Docker files and Docker-compose definitions for their development and production environments.

We can directly re-use this good work for packaging and contribute back by helping maintain their in-repository files. We meet them where they are at and do not create a new packaging format or duplicate effort.

Co-op cloud proposes the idea of more direct coordination between distribution methods (app packagers) and production methods (developers).

## Aren't containers horrible from a security perspective?

It depends, just like any other technology and understanding of security. Yes, we've watched [that CCC talk](https://media.ccc.de/v/rc3-49321-devops_disasters_3_1).

It's on us all as the libre software community to deliver secure software and we think one of the promises of Co-op Cloud is better cooperation with developers of the software (who favour containers as a publishing format) and packagers and hosters (who deliver the software to the end-user).

This means that we can patch our app containers directly in conversation with upstream app developers and work towards a culture of security around containers.

We definitely recommend using best-in-class security auditing tools like [docker-bench-security](https://github.com/docker/docker-bench-security), IDS systems like [OSSEC](https://www.ossec.net/), security profiles like [Apparmor](https://docs.docker.com/engine/security/apparmor/) and hooking these into your existing monitoring, alert and update maintenance flows.

Co-op also allows you to compartmentalise different applications onto different servers. You could stack a bunch of apps on one big server or you could deploy one app per server.

These are organisational concerns that Co-op Cloud can't solve for you which any software system will require. See this [additional question](/faq/#what-is-important-to-consider-when-running-containers-in-production) for further information.

## What is important to consider when running containers in production?

The Co-op Cloud uses [containers](/faq/#why-containers) as a fundamental building block. Therefore it is important to be aware of some general principles for container management in production environments. These are typically things that you will want to discuss within your co-op or democratic collective about how to prioritise and build up process for.

However, as the Co-op Cloud project is still very young, we're also still thinking about how we can make the platform itself mitigate problematic issues and make the maintenance of containers a more stable experience.

With that all in mind, here are some leading thoughts.

- How do you install the Docker daemon itself on your systems and how do you manage upgrades? (system package, upstream Docker Inc. repository?)
- How do you secure the Docker daemon from remote access (firewalls and system access controls).
- How do you secure the Docker daemon socket within the swarm (locking the socket down, using things like a [socket proxy](https://github.com/Tecnativa/docker-socket-proxy))
- How do you trust the upstream container registry (there are [content trust mechanisms](https://docs.docker.com/engine/security/trust/) but it seems also useful to think about whether we need community registry infrastructure using tools like [harbor](https://goharbor.io/) or [distribution](https://github.com/distribution/distribution). This involves a broader discussion with upstream communities.)
- How do I audit my container security in an on-going process (IDS, OSSEC, Apparmor, etc.)
- Can I run my containers with a [non-root user setup](https://docs.docker.com/engine/security/rootless/)?

## Why use the Compose specification?

Every application packaged for the Co-op Cloud is described using a file format which uses the [compose specification](https://compose-spec.io/). It is important to note that we do not use the [Docker compose](https://docs.docker.com/compose/) tool itself to deploy apps using this format, instead we rely on [Docker swarm](https://docs.docker.com/engine/swarm/stack-deploy/).

The compose specification is a useful open standard for specifying libre software app deployments in one file. It appears to be the most accessible format for describing apps and this can be seen in the existence of tools like [Kompose](https://kompose.io/) where the compose format is used as the day-to-day developer workflow format which is then translated into more complicated formats for deployment.

We are happy to see the compose specification emerging as a new open standard because that means we don't have to rely on Docker Inc. in the future - there will be more community tools available.

## Why Docker Swarm?

While many have noted that "swarm is dead" it is in fact [not dead](https://www.mirantis.com/blog/mirantis-will-continue-to-support-and-develop-docker-swarm/). As detailed in the [architecture overview page](/overview/#container-orchestrator), swarm offers an appropriate feature set which allows us to support zero-down time upgrades, seamless application rollbacks, automatic deploy failure handling, scaling, hybrid cloud setups and maintain a decentralised design.

While the industry is bordering on a [k8s](https://kubernetes.io/) obsession and the need to [scale down](https://microk8s.io/) a tool that was fundamentally built for massive scale, we are going with swarm because it is the tool most suitable for [small technology](https://small-tech.org/).

We hope to see a container orchestrator tool that is not directly linked to a for-profit company emerge soon but for now, this is what we have.

## What licensing model do you use?

The Co-op Cloud is and will always be available under [copyleft licenses](https://en.wikipedia.org/wiki/Copyleft).

## Isn't running everything in containers inefficient?

It is true that if you install 3 applications and each one requires a MySQL database, then you will have 3 installations of MySQL on your system, running in containers.

Systems like [YunoHost](/faq/#yunohost) mutualise every part of the system for maximum resource efficiency - if there is a MySQL instance available on the system, then just make a new database there and share the MySQL instance instead of creating more.

However, as we see it, this creates a tight coupling between applications on the database level - running a migration on one application where you need to turn the database off takes down the other applications.

It's a balance, of course. In this project, we think that running multiple databases and maintaining more strict application isolation is worth the hit in resource efficiency.

It is easier to maintain and migrate going forward in relation to other applications and problems with apps typically have a smaller problem space - you know another app is not interfering with it because there is no interdependency.

It can also pay off when dealing with GDPR related issues and the need to have more stricter data layer separation.
