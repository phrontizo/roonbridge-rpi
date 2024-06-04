# roonbridge-rpi
Docker file for running The HiFiBerry Roon RAAT endpoint on a Raspberry Pi (tested on a RPi 3B+ running Ubuntu with a HiFiBerry DAC+ only). "dtoverlay=hifiberry-dacplus" must be in your config.txt for this to work.

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
Runs as UID nobody, GID 29 (audio on Ubuntu and Debian). Needs to run as a GID that has rw access to `/dev/snd` - set the AUDIO_GROUP environment variable to the numeric ID of the audio group as as appropriate for your host system.

