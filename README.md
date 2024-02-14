## Installation
It is possible to run autodarts in a docker container.

If you do not know how to install docker, you can follow [this](https://docs.docker.com/engine/install/) guide.

Please note that this is only available for linux based systems with either arm64 or amd64 architectures so far.

Before getting started, you will have to know the names of your camera interfaces.

You can find them with a tool like `v4l2-utils`:
```sh
sudo apt install v4l2-utils
v4l2-ctl --list-devices
```
in the output, you will see your cameras. What you need is the first device path for each of them (in my case `/dev/video0`, `/dev/video2` and `/dev/video4`:
```
USB HD Camera: USB HD Camera (usb-0000:01:00.0-1.2):
        /dev/video0
        /dev/video1
        /dev/media4

USB HD Camera: USB HD Camera (usb-0000:01:00.0-1.3):
        /dev/video2
        /dev/video3
        /dev/media5

USB HD Camera: USB HD Camera (usb-0000:01:00.0-1.4):
        /dev/video4
        /dev/video5
        /dev/media6
```

Use the following docker-compose configuration and add your devices in the `devices` section accordingly:
```yml
version: '3.3'
services:
  autodarts:
    image: michvllni/autodarts:latest
    container_name: autodarts
    restart: unless-stopped
    ports:
    - 3180:3180
    devices:
    - /dev/video0:/dev/video0
    - /dev/video2:/dev/video2
    - /dev/video4:/dev/video4
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
