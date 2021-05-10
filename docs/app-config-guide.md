---
title: Application config guide
---

# Keycloak

## How do I setup a custom theme?

Check [this approach](https://git.autonomic.zone/ruangrupa/login.lumbung.space).

# Nextcloud

## How do I customise the default home page when logging in?

- Delete the dashboard app since it is so corporate
- Follow [these docs](https://docs.nextcloud.com/server/latest/admin_manual/configuration_files/default_files_configuration.html) to set the default files list for each user in the Files app
- Configure a `defaultapp` in your `config.php` or use [apporder](https://apps.nextcloud.com/apps/apporder)

## How do I integrate with Keycloak SSO?

Use [this plugin](https://github.com/pulsejet/nextcloud-oidc-login). You can use [this trick](https://janikvonrotz.ch/2020/10/20/openid-connect-with-nextcloud-and-keycloak/) (see "Cryptic Usernames" work-around) to get proper usernames.

> TODO(decentral1se): copy over keycloak client config and nextcloud config.php

## Why is my synchronisation client freezing on the "grant access" step?

Please see [this ticket](https://git.autonomic.zone/coop-cloud/nextcloud/issues/5).

## How can I customise the CSS on the NC?

There is some basic stuff in the admin settings.

To go a little deeper, you can use [this handy app](https://apps.nextcloud.com/apps/theming_customcss).

## Drone

## Generating deploy keys

We normally do something like the following.

```bash
$ ssh-keygen -t ed25519 -C drone@swarm.autonomic.zone
```

When you're loading them into Drone, make sure to use the right name of the organisation when using `drone orgsecret add`.

## How to change orgsecret values

First, get your Drone CLI tool downloaded and the environment configured.

```bash
$ export DRONE_SERVER=https://drone.example.com
$ export DRONE_TOKEN=$(pass show your-pass-store-path)
$ curl -L https://github.com/drone/drone-cli/releases/latest/download/drone_linux_amd64.tar.gz | tar zx
```

Then you can do things like:

```
$ ./drone orgsecret ls
$ ./drone orgsecret add someorg my_deploy_key @my_private_key_file
```

## How to enable build failure notifications

Add this to your `.drone.yml` file. See the [plugin docs](http://plugins.drone.io/drone-plugins/drone-slack/) for more.

```yaml
- name: notify rocket chat
  image: plugins/slack
  depends_on: ["mybuild"]
  settings:
    webhook:
      from_secret: rc_builds_url
    username: foobar
    channel: "builds"
    template: "{{repo.owner}}/{{repo.name}} build failed: {{build.link}}"
  when:
    status:
      - failure
```

!!! warning

    You must include valid names of pipelines in your `depends_on` list field.
    This is so that the notification will wait until all other pipelines are
    run before performing the notification logic.

## Skipping CI builds

Add `[ci skip]` into the git commit message. You don't have to run builds if you don't want to.

# Gitea

> TODO

# Peertube

## How do I wire up Keycloak SSO?

Use [this plugin](https://framagit.org/framasoft/peertube/official-plugins/tree/master/peertube-plugin-auth-openid-connect).

## How do I develop a custom theme?

See [this approach](https://git.autonomic.zone/ruangrupa/peertube-plugin-lumbung-space).
