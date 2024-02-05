# Autodarts Board Client

You can install autodarts on a Linux system by using this single command.
It will automatically download the latest version and install a systemd service to automatically start autodarts on startup.
You might have to install `curl` on your machine beforehand.
You can do so with `sudo apt install curl`.

```bash
bash <(curl -sL get.autodarts.io)
```

If you do not want the autostart systemd service to be installed, you can use the `-n` flag as follows.

```bash
bash <(curl -sL get.autodarts.io) -n
```

If you do not want the automatic updater systemd service to be installed, you can use the `-u` flag as follows.

```bash
bash <(curl -sL get.autodarts.io) -u
```

If you want to install a specific version, say, `0.16.0`, then you can append the required version to the command as follows.
This can be helpful if you want to downgrade to an earlier version.
This also works with the `-n` and `-u` flag from before.

```bash
bash <(curl -sL get.autodarts.io) 0.16.0
```

You can control the the `autodarts.service` with the `systemctl` command.

```bash
sudo systemctl start autodarts
sudo systemctl stop autodarts
sudo systemctl restart autodarts
sudo systemctl status autodarts
sudo systemctl disable autodarts
sudo systemctl enable autodarts
```

If you want to see the log output, you can use the following command.

```bash
journalctl -u autodarts -f
```

For Windows and MacOS, which are not well tested, you can go to the releases pages and download the individual versions directly from there.
Make sure that you download the correct version for your Mac, Intel vs Apple Silicon (`amd64` vs `arm64`).

## UVC Hack

If your setup requires the UVC hack, you can now install it with the following command.

```bash
bash <(curl -sL get.autodarts.io/uvc)
```

You can reset the system to the original driver file by passing the `--uninstall` flag as follows.

```bash
bash <(curl -sL get.autodarts.io/uvc) --uninstall
```

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

To view the logs, use `sudo docker compose logs`
If you wish to follow the logs, you can use `sudo docker compose logs -f`
If you wish to restart the container, you can use `sudo docker compose restart`
