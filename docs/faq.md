---
title: Frequently asked questions
---

## What is the Co-op Cloud?

Co-op Cloud aims to make hosting free software applications simple for small providers. It uses the latest container technologies and innovations and configurations are shared into [the commons](https://en.wikipedia.org/wiki/Commons) for the benefit of all. The project is intended for small service providers such as tech co-operatives who are looking to standardise around an open, transparent and scalable infrastructure.

## Who is behind the project?

The project was started by workers at [Autonomic](https://autonomic.zone/) which is a [workers co-operative](https://en.wikipedia.org/wiki/Worker_cooperative) providing technologies and infrastructure to empower users to make a positive impact on the world. We use Co-op Cloud in production amongst other systems.

## Why Co-op Cloud?

#### 👍

- 👍 Thin "ease of use" layer on top of already standardised tooling
- 👍 Extremely modular
- 👍 Collective commons based configuration via public git repos
- 👍 Focussed on hosting providers
- 👍 Uses upstream packages
- 👍 Now and always free software
- 👍 Command line focussed
- 👍 Horizontal and vertical scaling

#### 👎

- 👎 Still a very young project
- 👎 Limited availability of well tested apps
- 👎 Requires command line knowledge to use
- 👎 Currently x86 only

## Why start another project?

Please read our [initial project announcement post](#TODO) for more on this.

## What about `$alternative`?

We have various technical critiques of other similar projects which are already
up-and-running in the ecosystem as they don't necessarily meet our needs as a small tech co-op. However, the Cooperative Cloud isn't meant to be a replacement for these others projects. Here is a short overview of the pros/cons we see and how that relates to our goals here.

### Cloudron

#### 👍

- 👍 Decent web interface for application, domain & user management.
- 👍 Large library of applications.
- 👍 Built-in SSO using LDAP, which is compatible with more applications and often has a better user interface than OAuth.
- 👍 Applications are actively maintained by the Cloudron team.

#### 👎

- 👎 Moving away from open source. The core is now proprietary software.
- 👎 Free tier has a single application limit.
- 👎 Based on Docker images, not stacks, so multi-process applications (e.g. parsoid visual editor for Mediawiki) are a non-starter.
- 👎 Difficult to extend applications.
- 👎 Only supported on Ubuntu LTS.
- 👎 Upstreams free software communities aren't involved in packaging.
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

#### 👎

- 👎 Upstream free software communities aren't involved in packaging.
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

We use containers because so many libre software communities choose to use them! They are already writing and using Docker files and Docker-compose definitions for their development and production environments. We can directly re-use this good work for packaging and contribute back by helping maintain their in-repository files. We meet them where they are at and do not create a new packaging format or duplicate effort. Co-op cloud proposes the idea of more direct coordination between distribution methods (app packagers) and production methods (developers).

## Why Docker compose?

We are more focused on the [compose specification](https://compose-spec.io/) as a useful open standard for specifying libre software app deployments than the [Docker compose](https://docs.docker.com/compose/) tool itself. Compose files seem to be the most accessible format for describing apps and this can be seen in the existence of tools like [Kompose](https://kompose.io/) where the compose format is used as the day-to-day developer workflow format which is then translated into more complicated formats. Docker compose is simply the de-facto community standard tooling that is being used to read and execute compose files today and we're making use of it. We are happy to see the compose specification emerging as a new open standard because that means we don't have to rely on Docker Inc. in the future - there will be more community tools available.

## Why Docker Swarm?

While many have noted that "swarm is dead" it is in fact [not dead](https://www.mirantis.com/blog/mirantis-will-continue-to-support-and-develop-docker-swarm/). As detailed in the [architecture overview page](/overview/#container-orchestrator), swarm offers an approriate feature set which allows us to support zero-down time upgrades, seamless application rollbacks, automatic deploy failure handling, scaling, hybrid cloud setups and maintain a decentralised design. While the industry is bordering on a [k8s](https://kubernetes.io/) obsession and the need to [scale down](https://microk8s.io/) a tool that was fundamentally built for massive scale, we are going with swarm because it is the tool most suitable for [small technology](https://small-tech.org/). We hope to see a container orchestrator tool that is not directly linked to a for-profit company emerge soon but for now, this is what we have.

## What licensing model do you use?

The Cooperative Cloud is and will always be available under [copyleft licenses](https://en.wikipedia.org/wiki/Copyleft).
