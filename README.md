## Using the compose to start the machine

```bash
docker compose up -d --build && docker image prune -f
```

## Using the compose to rebuild the machine without cache and pulling the latest base images

```bash
docker compose build --no-cache --pull && docker compose up -d && docker image prune -f
```

## Enter with an interactive console

```bash
docker exec -it ID_CONT bash
```
