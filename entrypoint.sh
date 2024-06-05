#!/bin/bash

curl -sLO ${HIFIBERRY_BASE_URL}/raat/configure-raat
curl -sLO ${HIFIBERRY_BASE_URL}/raat/${RAAT_APP}
curl -sLO ${HIFIBERRY_BASE_URL}/alsa-eq/asound.conf.eq

chmod +x configure-raat
chmod +x ${RAAT_APP}
[ -s uuid ] || /usr/bin/uuidgen > uuid

# get a asound.conf
HW=`aplay -l | grep hifiberry | awk -F: '{print $1}'`
HW_SHORT=`echo $HW | awk '{print $2}'`
if [ "$HW_SHORT" == "" ]; then
  echo "No HiFiBerry sound card detected"
  return
fi
sed "s/card\s[0-9]/card\ $HW_SHORT/g" asound.conf.eq > /etc/asound.conf

./configure-raat

exec setpriv --reuid=nobody --regid=${AUDIO_GROUP} --init-groups ./${RAAT_APP} hifiberry_raat.conf
