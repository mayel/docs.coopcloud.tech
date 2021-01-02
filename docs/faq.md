---
title: Frequently Asked Questions
---

## What is the Cooperative Cloud?

The Cooperative Cloud is a platform built by and for worked-owned technology
cooperatives which proposes a shared social and technical infrastructure for
the operation and management of free software applications.

## What about <insert-your-favourite-alternative\>?

### Cloudron

- 👍 Lovely web interface for application, domain & user management
- 👍 Bigger library of applications
- 👍 Built-in SSO using LDAP, which is compatible with more applications and often has a better user interface than OAuth
- 👍 Most applications are actively maintained by the Cloudron team
- 👎 Moving away from open source. Free version has a 1-application limit
- 👎 Based on Docker images, not stacks, so multi-process applications (e.g. parsoid for Mediawiki) are a non-starter
- 👎 Difficult to extend applications
- 👎 Only supported on Ubuntu
- 👎 Upstreams free software communities aren't involved

### YunoHost

- 👍 Lovely web interface for application, domain & user management
- 👍 Bigger library of applications
- 👍 Awesome backup / deploy / restore continuous integration testing
- 👍 Supports hosting applications in subdirectories as well as subdomains
- 👍 Doesn't require a public-facing IP
- 👎 Upstreams free software communities aren't involved
- 👎 Often not idempotent: uninstalling applications leaves growing cruft

### Ansible

- 👍 Includes server creation and bootstrapping
- 👎 Upstream free software communities aren't publishing Ansible roles
- 👎 Lots of manual work involved in things like application isolation, backups, updates

### Kubernetes

- 👍 Helm charts are available for some key applications already
- 👎 Too big -- requires 3rd party tools to run a single-node instance

### Docker-compose

- 👎 Manual work required for process monitoring
- 👎 Secret storage not available yet
- 👎 [Swarm is the new best practice](https://github.com/BretFisher/ama/issues/8#issuecomment-367575011)

### Doing it Manually

- 👍 Simple - just follow upstream instructions to install and update
- 👎 Loads of manual work required for application isolation and backups
- 👎 Array of sysadmin skills required to install applications
- 👎 Hard to share configurations into the commons
