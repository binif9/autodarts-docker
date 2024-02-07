## Installation
It is possible to run autodarts in a docker container.

If you do not know how to install docker, you can follow [this](https://docs.docker.com/engine/install/) guide.

Please note that this is only available for linux based systems with either arm64 or amd64 architectures so far.

To get started, use the following docker-compose configuration:
```yml
version: '3.3'
services:
  autodarts:
    image: michvllni/autodarts:latest
    container_name: autodarts
    restart: unless-stopped
    ports:
    - 3180:3180
    privileged: true
    volumes:
    - ./config:/root/.config/autodarts
```

This configuration will automatically expose the cameras to the container and provide the board manager at http://servername:3180.

You can also find this configuration at [this link](https://raw.githubusercontent.com/michvllni/autodarts-releases/main/docker-compose.yml).

Save it into the directory of your choice, then navigate into that directory and execute `sudo docker-compose up -d`

## Useful commands
| Command | Explanation |
| --------| ----------- |
| `sudo docker compose logs` | Print the logs from the container |
| `sudo docker compose logs -f` | Follow the logs. Press ctrl+c to cancel |
| `sudo docker compose restart` | Restart the container |
| `sudo docker compose down` | Remove the container |
