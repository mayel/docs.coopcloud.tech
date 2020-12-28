# Setting up a new Docker swarm box

Create and provision a new VPS with Docker installed.

The easiest way of doing this is using [`actions/newhetzner.yml` in our `infrastructure` repository](https://git.autonomic.zone/autonomic-cooperative/infrastructure/src/branch/master/actions/newhetzner.yml).

Make sure you have `infrastructure` cloned and set up [according to the instructions](https://git.autonomic.zone/autonomic-cooperative/infrastructure/src/branch/master/README.md), then run `ansible-playbook actions/newhetzner.yml` and answer the questions.

1. Add the server to your `~/.ssh/config` file (you'll at least need to specify `Port 222`).
2. Add the suggested entry to [`inventories/inventory`](https://git.autonomic.zone/autonomic-cooperative/infrastructure/src/branch/master/inventories)
3. Create a new `servers/<client>/<server>.yml` file, based on `servers/neuronic/swarm.yml` (including the `swarm.single-node` role)
4. Run `ansible-playbook servers/<client>/<server>.yml` to install Docker

The easiest way forwards from here is to install `abra` and use it to set up remote context and initialise the swarm:

1. `curl -fsSL https://install.abra.autonomic.zone | bash`
2. `abra context create swarm.client.tld yourusername 222`
3. `abra context init swarm.client.tld`
4. `abra context use swarm.client.tld`
