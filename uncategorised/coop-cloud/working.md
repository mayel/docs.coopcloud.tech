# Working with Docker Swarm

## Set up remote context

You can use `docker context` to run Docker command-line commands and have them
point to the Docker API end-point on a remote host.

This means you can run commands locally and control the remote swarm easily
(e.g. you run `docker ps` and instead of seeing container on your `localhost`
you see them on `swarm.autonomic.zone`). This allows to do remote deployments
manually, filter logs, clean-up containers etc.

!!! note "This is optional!"
If you like, you can SSH to a swarm server, [install `docker-compose`](https://docs.docker.com/compose/install/#install-compose-on-linux-systems), and run normal Docker commands instead.

Here are the 3 steps to set this up.

1. Create the remote docker context locally.

   ```bash
   # .envrc.sample
   export PASSWORD_STORE_DIR=$(pwd)/../infrastructure/credentials/password-store
   ```

   ```bash
   $ cp .envrc.sample .envrc
   $ direnv allow  # ensure password store works
   $ mkdir -vp ~/.docker/swarm.autonomic.zone && \
     pass show docker/swarm.autonomic.zone/ca.pem > ~/.docker/swarm.autonomic.zone/ca.pem && \
     pass show docker/swarm.autonomic.zone/cert.pem > ~/.docker/swarm.autonomic.zone/cert.pem && \
     pass show docker/swarm.autonomic.zone/key.pem > ~/.docker/swarm.autonomic.zone/key.pem
   $ docker context create swarm.autonomic.zone --docker \
     "host=tcp://swarm.autonomic.zone:2376,ca=$HOME/.docker/swarm.autonomic.zone/ca.pem,cert=$HOME/.docker/swarm.autonomic.zone/cert.pem,key=$HOME/.docker/swarm.autonomic.zone/key.pem"
   $ docker context use swarm.autonomic.zone
   ```

2. Deploy the application to the remote docker context.

(Assuming you're in, say, the [git.autonomic.zone](https://git.autonomic.zone/autonomic-cooperative/git.autonomic.zone) repository)

```bash
$ docker stack ls
$ docker stack deploy -c compose.yml gitea
```

You can track logs via `docker service logs gitea_gitea`.

3. Switch back to your local context.

```
$ docker context use default
```

## Useful concepts & commands

Each app is a **stack**, e.g. `drone` (`docker stack ls`), which creates one or
more **services**, e.g. `drone_drone` (`docker service ls`), each of which has one or more
**containers** e.g. `drone_drone.1.czq919syweq23x07whj38pb96` (`docker container ls`). All of this is defined in a `docker-compose.yml` file.

Containers are built from **images**, e.g. `nginx:stable`, optionally using a
`Dockerfile` to add extra commands or resources.

### Secrets

Most apps will need secret values (like API keys), which Docker can store securely using `docker secret`.

As a failsafe, and to help debugging, we also store secrets in `pass`.

You can generate a password, store it to Docker, and save it to `pass` in one
step using something like this:

```
pwgen -n 32 1 | tee \
  >(docker secret create "APP_SECRET_v1" -)
  >(pass insert -m hosts/HOSTNAME/APP/SECRET)
```

Use `docker secrets ls` to see the names of all secrets defined in the current
context, and `docker secrets rm <NAME>` to remove one if you need to reset it.

## Troubleshooting

If a service is trying to start, but you don't see anything in `docker service logs ...`, then try `docker service ps --no-trunc`, which will show you errors
during container initialisation.

If you still don't see anything there, log into the swarm server and check the
Docker logs:

```
sudo journalctl -u docker.service | tail -n 50
```

## Investigating persistent journald logs

See [systemd-journald
docs](https://docs.autonomic.zone/coop-cloud/logging-with-systemd-journald/)
for more information on the systemd journal logging setup.
