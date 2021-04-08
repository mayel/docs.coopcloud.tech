# This script is intended to be run by `doitlive`[0], so it deliberately doesn't
# log the commands it's running -- as `doitlive` will display them. You can also
# run this using `bash.sh`, in which case it might be helpful to uncomment the
# `set -x` line below to see what this script is doing.
#
# [0]: https://doitlive.readthedocs.io/

#set -x

export ABRA_DIR=/tmp/abra_demo
mkdir -p $ABRA_DIR

curl https://install.abra.autonomic.zone | bash -s -- --dev

abra server add demo.autonomic.zone calix 222

abra server demo.autonomic.zone init

abra app new traefik --server demo.autonomic.zone --domain demo.autonomic.zone --app-name traefik_demo

abra -n app traefik_demo deploy --no-domain-poll

abra -n app new gitea --server demo.autonomic.zone --domain git.demo.autonomic.zone --app-name gitea_demo --secrets

abra -n app gitea_demo deploy
