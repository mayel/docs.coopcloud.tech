# Deploying an HTML website

1. Install abra
2. `abra app new custom-html`
3. Configure DNS to point YOUURDOMAIN.TLD to `116.203.211.204` (`swarm.autonomic.zone`)
3. `abra app YOURDOMAIN.TLD config` if you want to add domain aliases (e.g. `www`)
4. `abra app YOURDOMAIN.TLD deploy`

Manual deployment:

1. `cd` to the directory with everything in it
2. `tar cf - * | abra app YOURDOMAIN.TLD cp - app:/usr/share/nginx/html`

Automatic deployment:

1. Create `.drone.yml` file, e.g. here: https://git.autonomic.zone/kawaiipunk/writing/src/branch/main/.drone.yml
2. Make sure the `autonomic` user has access to the repo on Gitea
3. Log into Drone as autonomic and click "Sync"
4. Add the repo in Drone
5. Commit and push the `.drone.yml` file
