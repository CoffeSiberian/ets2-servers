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

If you want to verify that your server is online, you can use the following tool to check: https://ismygameserver.online/

## Troubleshooting server visibility

If the online checker shows your server as offline, make sure all of the following are true:

-   You have a dedicated public IP address.
-   The required ports are open on your network/firewall (27015–27016 by default, or whatever you configured).
-   The port numbers match exactly between Docker Compose port mapping and your `server_config.sii`. This 1:1 mapping is required.

If you don’t meet all of these conditions, your server will not appear in the public server list. However, players can still connect by using the `Session search id:` to find the session manually. This is handy because you can even host from any reasonably stable internet connection.
