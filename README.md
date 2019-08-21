# roonbridge-rpi
Docker file for running Roon Bridge on a Raspberry Pi (tested on LibreElec only, using the docker plugin).

This runs RoonBridge directly, bypassing the `start.sh` script. Logs and other persistent data go into `/var/roon`, which needs to be mapped to a volume or host directory. I have not tested it when RoonBridge updates yet. RoonBridge itself is not included in the image - it is downloaded and unpacked on first run.

## Running
```
docker run --detach \
           --restart always
           --device /dev/snd \
           --net host \
           -v roon_data:/var/roon \
           --name roonbridge \
           phrontizo/roonbridge-rpi
```
Runs as UID 1000, GID 63 (audio on LibreElec). Needs to run as a UID:GID that has rw access to `/dev/snd` - change as appropriate for your system.
