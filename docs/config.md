---
title: Manage your app configuration
---

Co-op Cloud stores per-app configuration in the `$USER/.abra/servers` directory, on whichever machine you're running `abra` on (by default, your own workstation).

The format of these configuration files is the same environment variable syntax used by Docker (with the `env_file:` statement in a `docker-compose.yml` file, or the `--env-file` option to `docker run`) and `direnv`:

```
abra app example_wordpress config
TYPE=wordpress

DOMAIN=wordpress.example.com
## Domain aliases
EXTRA_DOMAINS=', `www.wordpress.example.com`'
LETS_ENCRYPT_ENV=production
...
```

`abra` doesn't mind if `~/.abra/servers`, or any of its subdirectories, is a [symlink], so you can keep your app definitions wherever you like!

```
mv ~/.abra/servers/ ~/coop-cloud
ln -s ~/coop-cloud ~/.abra/servers
```

## Backing up your app configuration

Just make sure the `~/.abra/servers` is included in the configuration of your favourite backup tool.

You can optionally also backup `~/.abra/apps`, if you'd like to keep an exact copy of the application versions you currently have deployed. Otherwise, they'll be automatically downloaded the first time you run an `abra app...` command.

You don't need to worry about `~/.abra/vendor` or `~/.abra/src` directories, which will be likewise recreated automatically as and when you need them.

<a id="version-control"></a>

## Version-control your app configs (using git)

Because `~/.abra/servers` is a collection of plain-text files, it's easy to keep your backup configuration in a version control system (we use `git`, others would almost certainly work).

This is particularly recommended if you're collaborating with others, so that you can all run `abra app...` commands without having to maintain your own separate, probably-conflicting, configuration files.

In the simple case where you only have one server configured with `abra`, or everyone in your team is using the same set of servers, you can version-control the whole `~/.abra/servers` directory:

```
cd ~/.abra/servers
git init
git add .
git commit -m "Initial import"
```

!!! warning "Test your revision-control self-discipline"

    	`abra` does not yet help keep your app definitions are up-to-date.

    	Make sure to run `git add` / `git commit` after making configuration changes, and `cd ~/.abra/servers && git pull` before running `abra app...` commands.

    	Patches to add some safety checks and auto-updates would be very welcome! 🙏

## Collaborating with multiple teams

In a more complex situation, where you're using Co-op Cloud to manage several servers, and you're collaborating with different people on different servers, you can set up **a separate repository for each subdirectory in `~/.abra/servers`**, or even a mixture of single-server and multi-server repositories:

```
ls -l ~/.abra/servers
# Example.com's own app configuration:
lrwxrwxrwx. 1 user user 49 Oct 30 22:42 swarm.example.com -> /home/user/Example/coop-cloud-apps/swarm.example.com
# Configuration for one of Example.com's clients – part of the same repository:
lrwxrwxrwx. 1 user user 49 Oct 30 22:42 swarm.client.com -> /home/user/Example/coop-cloud-apps/swarm.client.com
# A completely separate project, part of a different repository:
lrwxrwxrwx. 1 user user 49 Oct 30 22:42 swarm.demonstration.com -> /home/user/Demonstration/coop-cloud-apps
```

To make setting up these symlinks easier, you might want to include a simple installer script in your configuration repositories.

We don't have a public example of this yet, but something like this should do the trick:

1. Save this as `Makefile` in your repository:

   ```
   # -s symlink, -f force creation, -F don't create symlink in the target dir
   link:
   	@mkdir -p ~/.abra/servers/
   	@for SERVER in $$(find -maxdepth 1 -type d -name "[!.]*"); do \
   		echo ln -sfF "$$(pwd)/$${SERVER#./}" ~/.abra/servers/ ; \
   		ln -sfF "$$(pwd)/$${SERVER#./}" ~/.abra/servers/ ; \
   	done
   ```

   This will set up symlinks from each directory in your repository to a correspondingly-named directory in `~/.abra/servers` – if your repository has a `swarm.example.com` directory, it'll be linked as `~/.abra/servers/swarm.example.com`.

2. Tell your collaborators (e.g. in the repository's `README`), to run `make` in their repository check-out.

!!! warning "You're on your own!"

    As with the [simple repository set-up above](#version-control), `abra` doesn't yet help you update your version control system when you make changes, nor check version control to make sure you have the latest configuration.

    Make sure to `commit` and `push` after you make any configuration changes, and `pull` before running any `abra app...` commands.

## Even more granularity?

The plain-text, file-based configuration format means that you could even keep the configuration for different apps on the same server in different repositories, e.g. having `git.example.com` configuration in a separate repository to `wordpress.example.com`, using per-file symlinks.

We don't currently recommend this, because it might set inaccurate expectations about the security model – remember that, by default, **any user who can deploy apps to a Docker Swarm can manage _any_ app in that swarm**.

[symlink]: https://en.wikipedia.org/wiki/Symlink
