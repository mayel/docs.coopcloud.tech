# Running wp-cli commands

Here is an example how to drop into a shell and run `wp` commands. Just change the relevant details for your project.

```bash
export CONTAINER_ID=$(DOCKER_CONTEXT=swarm.autonomic.zone docker container ls -f 'Name=boycott-turkey_net_app' --format '{{ .ID }}'); DOCKER_CONTEXT=swarm.autonomic.zone docker run -it --volumes-from "$CONTAINER_ID" --network "container:$CONTAINER_ID" wordpress:cli
```

```bash
export CONTAINER_ID=$(DOCKER_CONTEXT=swarm.autonomic.zone docker container ls -f 'Name=boycott-turkey_net_app' --format '{{ .ID }}'); DOCKER_CONTEXT=swarm.autonomic.zone docker run -it --volumes-from "$CONTAINER_ID" --network "container:$CONTAINER_ID" wordpress:cli user create
usage: wp user create <user-login> <user-email> [--role=<role>] [--user_pass=<password>] [--user_registered=<yyyy-mm-dd-hh-ii-ss>] [--display_name=<name>] [--user_nicename=<nice_name>] [--user_url=<url>] [--nickname=<nickname>] [--first_name=<first_name>] [--last_name=<last_name>] [--description=<description>] [--rich_editing=<rich_editing>] [--send-email] [--porcelain]
```
