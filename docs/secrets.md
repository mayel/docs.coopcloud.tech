---
title: Managing secret data
---

# Managing secret data

Co-op Cloud uses [Docker Secrets] to handle sensitive data, like database passwords and API keys, securely:

```
$ DOCKER_CONTEXT=swarm.example.com docker secret ls
example_mediawiki_db_password_v1
example_wordpress_db_password_v1
```

`abra` includes several commands to make it easier to manage secrets:

- `abra app <app> secret generate` -- to auto-generate a single secret, or all secrets defined by the app, and store them in the Docker Swarm store,
- `abra app <app> secret insert` -- to insert a single secret value from the Docker Swarm store,
- `abra app <app> secret delete` -- to remove a single secret, or all secrets defined in the app, from the Docker Swarm store.

<a id="versions"></a>

## Secret versions

You will notice `v1` in the example secret names above: like Docker Configs, Docker Secrets are [immutable], which means that their values can't be changed after they're set. To accommodate this, Co-op Cloud uses the established convention of "secret versions". Every time you change (rotate) a secret, you will insert it as a new version.

Because secret versions are managed per-instance by the people deploying their apps, secret versions are stored in the `.env` file for each app:

```
$ find -L ~/.abra/servers/ -name '*.env' -print0 | xargs -0 grep -h SECRET
OIDC_CLIENT_SECRET_VERSION=v1
RPC_SECRET_VERSION=v1
CLIENT_SECRET_VERSION=v1
...
```

If you try and add a secret version which already exists, Docker will helpfully complain:

```
$ abra app example_wordpress secret insert db_password v1 foobar
Error response from daemon: rpc error: code = AlreadyExists desc = secret example_wordpress_db_password_v1 already exists
```

By default, new app instances will look for `v1` secrets.

## Generating secrets automatically

You can generate secrets in one of two ways:

1. While running `abra app new <type>`, by passing `--secrets`
2. At any point once an app instance is defined, by running `abra app <app> secret generate ...` (see `abra help secret generate` for full options)

!!! note "How are secrets generated?"

    	Depending on how the app is configured, you will require the `pwqgen` (from `passwdqc`) and `pwgen` binaries by default, although you can specify your own password-generation app when running `abra <app> secret generate` by providing the `<cmd>` argument.

## Inserting secrets manually

For third-party API tokens, like OAuth client secrets, or keys for services like Mailgun, you will be storing values you already have as the appropriately-named Docker secrets. `abra` provides a convenient interface to the underlying `docker secret create` command:

```
abra app example_wordpress secret insert db_password v2 "your-secret-here"
```

## Rotating a secret

So, given how [secret versions](#versions) work, here's how you change a secret:

1. Find out the current version number of the secret, e.g. by running `abra app example_wordpress config`, and choose a new one. Let's assume it's currently `v1`, so by convention the new secret will be `v2`.
2. Generate or insert the new secret:
   ```
   abra app example_wordpress secret generate db_password v2
   ```
   or
   ```
   abra app example_wordpress secret insert db_password v2 "foobar"
   ```
3. Edit the app configuration to change which secret version the app will use:
   ```
   abra app example_wordpress config
   ```
4. Re-reploy the app with the new secret version:
   ```
   abra app example_wordpress deploy
   ```

## Storing secrets in `pass`

The Co-op Cloud authors use the [UNIX `pass` tool][pass] to share sensitive data, including Co-op Cloud secrets, and `abra <app> secret...` commands include a `--pass` option to automatically manage generated / inserted secrets:

```
# Store generated secrets in `pass`:
abra app new wordpress --secrets --pass
abra app example_wordpress secret generate --all --pass
# Store inserted secret in `pass`:
abra app example_wordpress secret insert db_password v2 --pass
# Remove secrets from Docker, and `pass`:
abra app example_wordpress secret rm --all --pass
```

This functionality currently relies on our specific `pass` structure; patches to make that configurable are very welcome!

## What makes secrets secure?

TODO

[docker secrets]: https://docs.docker.com/engine/swarm/secrets/
[immutable]: https://en.wikipedia.org/wiki/Immutable_object
[pass]: https://www.passwordstore.org
