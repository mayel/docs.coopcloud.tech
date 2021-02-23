---
title: Frequently asked questions
---

## What is the Co-op Cloud?

The Co-op Cloud is a project which aims to make self-hosting free software applications simple! It's a project which fits in alongside others like [Cloudron](https://www.cloudron.io/), [Yunohost](https://yunohost.org/) and [Freedombone](https://freedombone.net/) and others but has its own specific focus. The project is intended for existing small service providers and cooperatives already involved in hosting work who are looking for alternatives.

## Which technologies?

The core technologies are free software and enjoy wide adoption across free
software developer communities.

- [Containers](#why-do-you-use-containers)
- [Docker compose](#why-do-you-use-docker-compose)
- [Docker swarm](#why-do-you-use-docker-swarm)

## Who packages your applications?

One of your main aims is to re-use existing work that free software communities
are already doing.

## Why containers?

We use containers because so many free software communities choose to use them!
They are already writing and using Docker files and Docker-compose definitions
for their development and production environments. We can directly re-use this
good work for packaging and contribute back by helping maintain their
in-repository files. We meet them where they are at and we do not create a new
packaging format or duplicate effort. We tie our distribution directly into
existing developer Coop cloud is about re-using upstream free software project
container based workflows through well known CI/CD automation tools and issue
trackers. Coop cloud proposes the idea of more direct coordination between
distribution methods (app packagers) and production methods (developers).

## Why Docker Compose?

## Why Docker Swarm?

## Why start another project?

One of our core principles is to not re-invent the wheel. However, fitting needs into existing projects doesn't always work out. Some of the developers on this project were also once developers on the other existing projects.

## What about `$alternative`?

We have our critiques of other similar projects which are already up-and-running in the ecosystem. However, the Co-op Cloud isn't meant to be a replacement for these projects. Here is a short overview of the pros/cons we see and how that relates to our goals here.

### Cloudron

#### 👍

- 👍 Lovely web interface for application, domain & user management
- 👍 Bigger library of applications
- 👍 Built-in SSO using LDAP, which is compatible with more applications and often has a better user interface than OAuth
- 👍 Most applications are actively maintained by the Cloudron team

#### 👎

- 👎 Moving away from open source. Free version has a 1-application limit
- 👎 Based on Docker images, not stacks, so multi-process applications (e.g. parsoid for Mediawiki) are a non-starter
- 👎 Difficult to extend applications
- 👎 Only supported on Ubuntu
- 👎 Upstreams free software communities aren't involved

### YunoHost

#### 👍

- 👍 Lovely web interface for application, domain & user management
- 👍 Bigger library of applications
- 👍 Awesome backup / deploy / restore continuous integration testing
- 👍 Supports hosting applications in subdirectories as well as subdomains
- 👍 Doesn't require a public-facing IP

#### 👎

- 👎 Upstreams free software communities aren't involved
- 👎 Often not idempotent: uninstalling applications leaves growing cruft

### Ansible

#### 👍

- 👍 Includes server creation and bootstrapping

#### 👎

- 👎 Upstream free software communities aren't publishing Ansible roles
- 👎 Lots of manual work involved in things like application isolation, backups, updates

### Kubernetes

#### 👍

- 👍 Helm charts are available for some key applications already

#### 👎

- 👎 Too big -- requires 3rd party tools to run a single-node instance

### Docker-compose

#### 👎

- 👎 Manual work required for process monitoring
- 👎 Secret storage not available yet
- 👎 [Swarm is the new best practice](https://github.com/BretFisher/ama/issues/8#issuecomment-367575011)

### Doing it Manually

#### 👍

- 👍 Simple - just follow upstream instructions to install and update

#### 👎

- 👎 Loads of manual work required for application isolation and backups
- 👎 Array of sysadmin skills required to install applications
- 👎 Hard to share configurations into the commons

## What licensing model do you use?

The Co-op Cloud will always be available under copyleft licenses.
