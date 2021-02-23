---
title: Deploy your first application
---

In order to deploy an application you need two things:

1. a server (e.g. [Hetzner VPS](https://www.hetzner.com/cloud))
2. a DNS provider (e.g. [Gandi](https://www.gandi.net/en))

## Create your server

Whether you are self-hosting or using a corporate cloud, Co-op Cloud has itself near zero system requirements. You only need to worry about the system resource usage of your apps and the overhead of running containers with the docker runtime (often negligible). We will deploy a new Nextcloud instance in this guide, so you will only need 1GB of RAM according to [their documentation](https://docs.nextcloud.com/server/latest/admin_manual/installation/system_requirements.html).

## Wire up your DNS

Typically, you'll need two A records, one to point to the VPS itself and another to support sub-domains for the apps. You can then support an app hosted on your root domain (e.g. `example.com`) and other apps on sub-domains (e.g. `foo.example.com`, `bar.example.com`). Your entries in your DNS provider setup might look like the following.

    @  1800 IN A 116.203.211.204
    *. 1800 IN A 116.203.211.204

Where `116.203.211.204` can be replaced as the IP address of your server.

## Install server prerequisites

On your server, you'll want to install [Docker](https://www.docker.com/). This can be done by following the [install documentation](https://docs.docker.com/engine/install/).

## Bootstrap abra

Once your DNS and docker daemon are up, you can install [abra](https://git.autonomic.zone/autonomic-cooperative/abra) locally on your developer machine and hook it up to your server.

Firstly, install `abra` locally.

```bash
$ curl https://install.abra.autonomic.zone | bash
```

The source for this script [is here](https://git.autonomic.zone/coop-cloud/abra/src/branch/main/installer/installer).

You may need to add the `~/.local/bin/` directory with your `$PATH` in order to run the executable.

```bash
$ export PATH=$PATH:$HOME/.local/bin
$ abra --help  # check it works
```

Now you can connect `abra` with your new server.

```bash
$ abra server add example.com
```

Where `example.com` is replaced with your identifier for your server DNS.

`abra server add` accepts also a `<user>` and `<port>` argument for your custom SSH connection details. What is happening here is that you are using the underlying SSH connection to make a secure connection to the server installed Docker daemon. This allows `abra` to run remote deployments from your local development machine.

Once you've added the sever, you can initialise the new single-host swarm.

```bash
$ abra server init example.com
```

You will now have a new `~/.abra/` folder on your local file system which stores all the configuration of your Co-op Cloud instance. You can easily share this as a git repository with others.

## Deploy Traefik

In order to have your Co-op cloud installation automagically provision SSL certificates, we will first install [Traefik](https://doc.traefik.io/traefik/). This tool is the main entrypoint for all web requests (e.g. like NGINX) and supports automatic SSL certificate configuration and other quality-of-life features which make deploying libre apps more enjoyable.

```bash
$ abra app new --server example.com --domain traefik.example.com traefik
$ abra app traefik.autonomic.zone deploy
```

## Deploy Nexcloud

And now we can deploy apps. Go ahead and create a new nextcloud app, generate secrets and deploy it.

```bash
$ abra app new --server example.com --domain cloud.example.com nextcloud
$ abra app cloud.example.com secret generate --all
$ abra app cloud.autonomic.zone deploy
```

Your Traefik instance should now detect that a new app is coming up and generate SSL certificates for it.
