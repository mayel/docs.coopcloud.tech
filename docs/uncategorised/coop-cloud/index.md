# About Coop Cloud

Coöp Cloud is our system for deploying and updating free software applications.

- 🔧 [Our own Coöp Cloud app configurations](https://git.autonomic.zone/autonomic-cooperative/coop-cloud-apps)
- 🍎 [Supported application list](https://codimd.autonomic.zone/49--AK0GQDWoxMq6-9ngTQ)
- 👁 [Coöp cloud overview](https://codimd.autonomic.zone/_M81xUukTCiBK96pgyC3DQ#) (portal to other CodiMD pads, including marketing copy)

We're currently using Coöp Cloud for some of our internal infrastructure:

- git.autonomic.zone
- drone.autonomic.zone
- id.autonomic.zone
- traefik.autonomic.zone

(all running on [`autonomic-swarm`](/servers/autonomic-swarm.md)), plus as many clients as we can, starting with:

- drone.neuronic-swarm.autonomic.zone (for [Neuronic Games](/clients/neuronic-games), running on [`neuronic-swarm`](/servers/neuronic-swarm.md))
- tankie.wiki (for Rebellious Data), running on `autonomic-swarm`
- wiki.jones.iww.org.uk (for IWW wiki), running on `iww-jones`

Relevant HOWTOs:

- [Set up a new Docker swarm box](setting-up-new-docker-swarm-box.md)
- [Working with Docker swarm](working-with-docker-swarm.md)
- [Logging with systemd-journald](logging-with-systemd-journald.md)
