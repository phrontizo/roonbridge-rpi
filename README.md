# roonbridge-rpi
Docker file for running The HiFiBerry Roon RAAT endpoint on a Raspberry Pi (tested on a RPi 3B+ running Ubuntu with HiFiBerry DAC+ and Digi Pro hats). `dtoverlay=hifiberry-dacplus` or similar must be in your config.txt for this to work.

The entrypoint for this downloads and configures the RAAT components of HiFiBerryOS, then runs raat_app. To upgrade, simply restart the container, which will retain the UUID so Roon keeps working correctly.

## Running
```
docker run --detach \
           --restart always \
           --device /dev/snd \
           --net host \
           -v raat:/raat \
           -e AUDIO_GROUP=63 \
           --name roonbridge \
           phrontizo/roonbridge-rpi
```
Runs as UID nobody, GID 29 (audio on Ubuntu and Debian). Needs to run as a GID that has rw access to `/dev/snd` - set the `AUDIO_GROUP` environment variable to the numeric ID of the audio group as as appropriate for your host system (63 as per the example above for LibreElec).

This is only tested on a 64-bit system (I don't have any 32-bit images to test it on). If you're on a 32-bit system, try adding `-e RAAT_APP=raat_app` to the above command and it might work. If not, raise an issue at the [Github page](https://github.com/phrontizo/roonbridge-rpi), 
