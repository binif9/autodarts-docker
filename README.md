## Docker installation
It is also possible to run autodarts in a docker container.
If you do not know how to install docker, you cann follow [this](https://docs.docker.com/engine/install/) guide.

Please note that this is only available for linux based systems with either arm64 or amd64 architectures so far.

To get started, use the following docker-compose configuration:
```yml
version: '3.3'
services:
  autodarts:
    image: ghcr.io/michvllni/autodarts:latest
    container_name: autodarts
    ports:
    - 3180:3180
    privileged: true
    volumes:
    - ./config:/root/.config/autodarts
```

This configuration will automatically expose the cameras to the container and provide the board manager at http://servername:3180.

You can also find this configuration at [This link](https://raw.githubusercontent.com/michvllni/autodarts-releases/main/docker-compose.yml).

Save it into the directory of your choice, then navigate into that directory and execute `sudo docker-compose up -d`

## Useful commands
To view the logs, use `sudo docker compose logs`
If you wish to follow the logs, you can use `sudo docker compose logs -f`
If you wish to restart the container, you can use `sudo docker compose restart`
