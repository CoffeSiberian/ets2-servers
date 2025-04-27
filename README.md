## Build an image with

```bash
docker build -t ets2server .
```

## Using the compose to start the machine

```bash
docker compose up -d
```

## Enter with an interactive console

```bash
docker exec -it <ID_CONTENEDOR> bash
```

The server configuration files can be found in: `/var/lib/docker/volumes`.
