---
title: Technical overview
---

The Co-op Cloud is made up of a few simple, composable pieces. The system does not rely on any one specific implementation: each part may be replaced and extended as needed.

- [Free software applications](#free-software-applications)
- [The packaging format](#the-packaging-format)
- [Container orchestrator](#container-orchestrator)
- [Command-line tool](#command-line-tool)

## Free software applications

Applications that you may already use in your daily life: [Nextcloud], [Jitsi], [Mediawiki], [Rocket.chat] and [many more]! These are tools that are created by volunteer communities who use [free software licenses] in order to build up the public software commons and offer more digital alternatives.

The communities who develop these softwares also publish them using containers. For example, here is the [Nextcloud hub.docker.com account] which allows end-users to quickly deploy a new Nextcloud instance.

Learn more about why we use containers [in the FAQ section](faq/#why-do-you-use-containers).

[nextcloud]: https://nextcloud.com
[jitsi]: https://jitsi.org
[mediawiki]: https://mediawiki.org
[rocket.chat]: https://rocket.chat
[many more]: /apps/
[free software licenses]: https://www.gnu.org/philosophy/free-sw.html
[nextcloud hub.docker.com account]: https://hub.docker.com/_/nextcloud

## The packaging format

The work required to take a new instance of an application and make it production ready is still too time intensive and often involves a duplication of effort. Each service provider needs to deal with the same problems: stable versioning, backup plan, secret management, upgrade plan, monitoring and the list goes on.

Therefore, the Co-op cloud proposes a packaing format which describes the entire production state of the application in a single place. This format is based on the [standards based compose specification] which is most commonly used by the [Docker compose] tool.

[Each application] that the Co-op cloud provides is described using the compose specification and makes use of the upstream project published container.

Learn more about why we use Docker compose [in the FAQ section](faq/#why-do-you-use-docker-compose).

[standards based compose specification]: https://compose-spec.io
[docker compose]: https://docs.docker.com/compose/
[each application]: /apps/

## Container orchestrator

Once we have our application packaged, we need a deployment environment. Production deployments are typically expected to support a number of features which give hosters and end-users guarantees for uptime, stability and scale.

The Co-op cloud makes use of [Docker swarm] as a deployment environment. It offers an approriate feature set which allows us to support zero-down time upgrades, seamless application rollbacks, automatic deploy failure handling, scaling, hybrid cloud setups and maintain a decentralised design.

Learn more about why we use Docker swarm [in the FAQ section](faq/#why-do-you-use-docker-swarm).

[docker swarm]: https://docs.docker.com/engine/swarm/

## Command-line tool

Finally, with an application and an application environment, we need a tool to read that package format and actually deploy it to the environment. For this, we have developed and published the [abra] command-line tool.

Abra aims at providing a simple command-line interface for managing your own co-operative cloud. You can bootstrap machines with the required tools, create new applications, deploy them, back them up, restore them and so on.

[abra]: https://git.autonomic.zone/coop-cloud/abra

## Moving forward

Now that you've got an overview, it is time to [deploy your first application].

[deploy your first application]: /deploy/
