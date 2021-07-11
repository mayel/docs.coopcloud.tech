---
title: Back-up and restore an app
---

We'll use the example of a [`coop-cloud/wordpress`][wordpress] app deployed at
`blog.example.com`.

## Backing up

```
abra app wordpress_blog_example_com backup --all
```

This will download backups of the Wordpress files (plugins, themes, and uploads)
and database (posts, settings and users) to the default backup directory,
`~/.abra/backups`.

You can also back up just the files:

```
abra app wordpress_blog_example_com backup app
```

or just the database:

```
abra app wordpress_blog_example_com backup db
```

!!! warning

    Not all types of apps know how to do backups yet -- if you see a message
    like `ERROR: 'nextcloud' doesn't know how to do app backups`, then extra
    code is needed in that app's `abra.sh` -- you might be able to add this
    yourself based on [`coop-cloud/wordpress` `abra.sh`][wordpress_abra.sh],
    otherwise please open a new issue (in this case for
    [`coop-cloud/nextcloud`][nextcloud]).

## Restore

You can restore data into a running application. This is useful to restore an
app to a previous state, to migrate an app from one Co-op Cloud server to
another, or to help move an app to Co-op Cloud initially.

Using the same example app above, you can restore files:

```
abra app wordpress_blog_example_com restore blog_example_com_app.tar.gz
```

and/or the database:

```
abra app wordpress_blog_example_com restore db blog_example_com_db.sql.gz
```

(there isn't yet a command to restore files and database data at the same time)

[wordpress]: https://git.autonomic.zone/coop-cloud/wordpress
[wordpress_abra.sh]: https://git.autonomic.zone/coop-cloud/wordpress/src/branch/master/abra.sh
[nextcloud]: https://git.autonomic.zone/coop-cloud/nextcloud
