---
title: Deploy your first app
---

In order to deploy an app you need two things:

1. a server (e.g. [Hetzner VPS](https://www.hetzner.com/cloud)), with
    - SSH access
    - a public IP address
2. a DNS provider (e.g. [Gandi](https://www.gandi.net/en))

## Create your server

Co-op Cloud has itself near zero system requirements. You only need to worry about the system resource usage of your apps and the overhead of running containers with the docker runtime (often negligible. If you want to know more, see [this FAQ entry](/faq/#isnt-running-everything-in-containers-inefficient)). We will deploy a new Nextcloud instance in this guide, so you will only need 1GB of RAM according to [their documentation](https://docs.nextcloud.com/server/latest/admin_manual/installation/system_requirements.html). You may also be interested in this [FAQ entry](/faq/#arent-containers-horrible-from-a-security-perspective) if you are curious about security in the context of containers.

## Wire up your DNS

Typically, you'll need two A records, one to point to the VPS itself and another to support sub-domains for the apps. You can then support an app hosted on your root domain (e.g. `example.com`) and other apps on sub-domains (e.g. `foo.example.com`, `bar.example.com`). Your entries in your DNS provider setup might look like the following.

    @  1800 IN A 116.203.211.204
    *. 1800 IN A 116.203.211.204

Where `116.203.211.204` can be replaced with the IP address of your server.

## Install server prerequisites

You'll want to install [Docker](https://www.docker.com/) both on your server and your local machine. This can be done by following the [install documentation](https://docs.docker.com/engine/install/).

On a [Debian system](https://docs.docker.com/engine/install/debian/), that can be done like so.

```bash
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt update
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
```

You'll probably want to add your user to the `docker` group:

```bash
usermod -a -G docker myusername
```

## Bootstrap `abra`

Once your DNS and docker daemon are up, you can install [`abra`](https://git.autonomic.zone/autonomic-cooperative/abra) locally on your developer machine and hook it up to your server.

Firstly, install `abra` locally.

!!! danger "Here be dragons"

    `abra` is written in Bash version 4 and if you have a version older than
    that, you will face issues. You can check your current bash version by
    running `bash --version`. Some developers of the tool are using Zsh > 5 and
    things work fine. Some MacOS users have had to use this [Homebrew
    formula](https://formulae.brew.sh/formula/bash#default) to upgrade their
    Bash.

```bash
curl https://install.abra.autonomic.zone | bash
```

The source for this script [is here](https://git.autonomic.zone/coop-cloud/abra/src/branch/main/installer/installer).

You may need to add the `~/.local/bin/` directory with your `$PATH` in order to run the executable.

```bash
export PATH=$PATH:$HOME/.local/bin
abra --help  # check it works
```

Now you can connect `abra` with your new server.

```bash
abra server add example.com
```

Where `example.com` is replaced with your server DNS name.

!!! note "About SSH"
    `abra` uses Docker's built-in SSH support to make a secure connection to a
    remote Docker daemon, to deploy and manage apps from your local development
    machine.

    If you need to specify a non-standard port, and/or different username, for SSH,
    add them as extra arguments:

    ```bash
    abra server add example.com username 2222
    ```

Once you've added the sever, you can initialise the [new single-host swarm](https://docs.docker.com/engine/swarm/key-concepts/).

```bash
abra server example.com init
```

You might see some messages from docker-swarm such as:

```bash
Swarm initialized: current node (<node id>) is now a
manager.

To add a worker to this swarm, run the following command:

    docker swarm join --token <token> <IP address>

To add a manager to this swarm, run 'docker swarm join-token manager'
and follow the instructions.

<node id>
```

You will now have a new `~/.abra/` folder on your local file system which stores all the configuration of your Co-op Cloud instance. You can easily share this as a git repository with others.

## Deploy Traefik

In order to have your Co-op cloud installation automagically provision SSL certificates, we will first install [Traefik](https://doc.traefik.io/traefik/). This tool is the main entrypoint for all web requests (e.g. like NGINX) and supports automatic SSL certificate configuration and other quality-of-life features which make deploying libre apps more enjoyable.

```bash
abra app new --server example.com --domain traefik.example.com traefik
```

We can then choose `traefik` as the app name.

You will want to take a look at your generated configuration and tweak the `LETS_ENCRYPT_EMAIL` value:

```bash
abra app traefik config
```

Every app you deploy will have one of these `.env` files, which contains variables which will be injected into app configurations when deployed. Variables starting with `#` are optional, others are required.

```
abra app traefik deploy
```

If you get a message like this:
```bash
ERROR: https://traefik.example.com still isn't up, check status by running "abra app traefik ps"
```
then it might need a few seconds more to start up. You can run `abra app traefik ps`, as suggested, to see when it's ready ??? look for `Running` under `CURRENT STATUS` ??? or `abra app traefik logs` to see app logs.

## Deploy Nextcloud

And now we can deploy apps.

Let's create a new Nextcloud app.

```bash
abra app new --server example.com --domain cloud.example.com nextcloud
```

We can then choose `nextcloud` as the app name.

And we need to generate secrets for the app: database connection password, root password and admin password. 

```bash
abra app nextcloud secret generate --all
```

If abra complains about lacking pwqgen, it is available in the packet passwdqc on debian. Install it with
```bash
sudo apt-get install passwdqc
```
and run the previous command again.

!!! warning

    Take care, these secrets are only shown once on the terminal so make sure
    to take note of them! `abra` makes use of the [Docker
    secrets](https://docs.docker.com/engine/swarm/secrets/) mechanism to ship
    these secrets securely to the server and store them as encrypted data.

Then we can deploy the Nextcloud.

```bash
abra app nextcloud deploy
```

And once again, we can watch to see that things come up correctly.

```bash
abra app nextcloud ps   # status check
abra app nextcloud logs # logs watch
```

!!! note

    Since Nextcloud takes some time to come up live, you can run the `ps`
    command under `watch` like so.

    ```bash
    watch abra app nextcloud ps
    ```

    And you can wait until you see that all containers have the "Running" state.

Your `traefik` instance will detect that a new app is coming up and generate SSL certificates for it.
