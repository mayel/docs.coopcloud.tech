# Logging with systemd-journald

The default Docker swarm logging driver is `json-file`, which is nice but
whenever a container is kiled or replaced, the logs are lost. This doesn't help
us when we want to look back and try to diagnose what hapened.

So, we change the default logging driver to use the systemd based journal
logging system. This is configured in the `/etc/systemd/journal.conf` and in
the `/etc/docker/daemon.json`. In practice, it means that logs are persistently
stored after containers go away, they are rotated and can be analysed later on.

`/etc/docker/daemon.json`:

```
{
    "log-driver": "journald",
    "log-opts": {
      "labels":"com.docker.swarm.service.name"
    }
}
```

`/etc/systemd/journal.conf`:

```
[Journal]
Storage=persistent
SystemMaxUse=5G
MaxFileSec=1month

```

There is also the [official docker
documentation](https://docs.docker.com/config/containers/logging/journald/) on
the journald logging driver.

Some useful commands:

- `journalctl -f`
- `journalctl CONTAINER_NAME=gitea_gitea.1.jxn9r85el63pdz42ykjnmh792 -f`
- `journalctl COM_DOCKER_SWARM_SERVICE_NAME=gitea_gitea --since="2020-09-18 13:00:00" --until="2020-09-18 13:01:00"`
- `journalctl CONTAINER_ID=$(docker ps -qf name=gitea_gitea) -f`

Also, for more system wide analysis stuff:

- `journalctl --disk-usage`
- `du -sh /var/log/journal/*`
- `man journalctl` / `man systemd-journald` / `man journald.conf`
