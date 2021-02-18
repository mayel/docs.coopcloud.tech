# CoöpCloud-ising an app

Example: Matomo web analytics

- Tired: Write your own image and compose file
- Wired: Use someone else's image (& maybe compose file)
- Inspired: Upstream image, someone else's compose file
- On fire: Upstream compose file

I'm feeling lazy so, luckily for me, Matomo already has an example compose file in their repository! Let's download and edit it:

```
mkdir matomo && cd matomo
wget https://raw.githubusercontent.com/matomo-org/docker/master/.examples/apache/docker-compose.yml -O compose.yml
```

Open `compose.yml` in your favourite editor and have a gander 🦢. There are a few things we're looking for – full list to come – but a few things we can immediately see are:

1. Let's bump the version to `3.8`, to make sure we can use all the latest swarm coolness
2. We load environment variables separately via `abra`, so we'll strip out `env_file`.
3. The `/var/www/html` volume definition on L21 is a bit overzealous; it means a copy of Matomo will be stored separately per app instance, which is a waste of space in most cases. We'll narrow it down according to the documentation – here, the developers have been nice enough to suggest `logs` and `config` volumes instead, which is a decent start
3. The MySQL passwords are sent as variables which is fine for basic use, but if we replace them with Docker secrets we can keep them out of our env files if we want to publish those more widely.
4. The MariaDB service doesn't need to be exposed to the internet, so we can define an `internal` network for it to communicate with Matomo.
5. Lastly, we want to use `deploy.labels` and remove the `ports:` definition, to tell Traefik to forward requests to Matomo based on hostname and generate an SSL certificate.

(The default `db` and `app` service names work great for us; if they were called things like `mariadb` and `matomo` we might want to rename them).

The resulting `compose.yml` is here: https://git.autonomic.zone/coop-cloud/matomo/src/branch/main/compose.yml

Now, create an `.envrc` file.

```
export APP=matomo
export DOMAIN=matomo.example.com
export STACK_NAME=matomo
export LETS_ENCRYPT_ENV=production

export SECRET_DB_PASSWORD_VERSION=v1
export SECRET_DB_ROOT_PASSWORD_VERSION=v1
```

(and, if you're using `.envrc`, remember to `source .envrc` or `direnv allow`)

For the moment, `abra` is missing its old features to deploy from a "stack" directory, so we'll go through the usual steps to create a new app:

1. `abra app new matomo`
2. `abra app YOURDOMAIN config` (edit as appropriate)
3. `abra app YOURDOMAIN secret auto` (add `–pass` if you'd like to save in
	 `pass`)
4. `abra deploy`

Then, open the `DOMAIN` you configured (you might need to wait a while for Traefik to generate SSL certificates) to finish the set-up.

Luckily, this container is (mostly) configurable via environment variables – if we want to auto-generate the configuration we can use a `config` and / or a custom `entrypoint` (see [`coop-cloud/mediawiki`](https://git.autonomic.zone/coop-cloud/mediawiki) for examples of both).

To-do:
 - Using a custom `entrypoint.sh` to do any initial set-up that relies on docker-compose run (e.g. for matrix-synapse)
 - How to replace `build:` in stacks
 - Adapting stacks which use bind-mounted volumes
