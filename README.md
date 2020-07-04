# roonbridge-rpi
Docker file for running The HiFiBerry Roon RAAT endpoint on a Raspberry Pi (tested on LibreElec only, with a HiFiBerry DAC+, using the docker plugin). "dtoverlay=hifiberry-dacplus" must be in your config.txt for this to work.

The entrypoint for this downloads and configures the RAAT components of HiFiBerryOS, then runs raat_app. To upgrade, simply restart the container, which will retain the UUID so Roon keeps working correctly.

## Running
```
docker run --detach \
           --restart always \
           --device /dev/snd \
           --net host \
           -v raat:/raat \
           --name roonbridge \
           phrontizo/roonbridge-rpi
```
Runs as UID 1000, GID 63 (audio on LibreElec). Needs to run as a UID:GID that has rw access to `/dev/snd` - change as appropriate for your system.

