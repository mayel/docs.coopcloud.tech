---
title: Troubleshooting
---

## SSH / connection problems

Assuming:
- Hostname: `coopcloud.example.com`
- User: `username`
- Port: `222`

### Step 1: Can you SSH to the server normally?

Does `ssh username@coopcloud.example.com -p2222` work?

If not, run through your standard oh-no-why-doesn't-SSH-work troubleshooting 🍀.

### Step 2: Can you run remote Docker commands over SSH?

Does `ssh username@coopcloud.example.com -p2222 docker ps` work?

If not:
- Is the remote Docker daemon running?
- Is your user in the `docker` group?

### Step 3: Does your Docker context work?

```
[user@hostname ~]$ DOCKER_CONTEXT=coopcloud.example.com docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```

If you get an error message instead:
- Use `abra server ls` / `docker context ls` to double-check the SSH connection details
- Try removing the context with `docker context rm coopcloud.example.com`, then re-add it
