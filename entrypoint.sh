#!/bin/bash

curl -sLO ${HIFIBERRY_BASE_URL}/${CONFIGURE_RAAT}
curl -sLO ${HIFIBERRY_BASE_URL}/${RAAT_APP}
chmod +x ${CONFIGURE_RAAT} && \
chmod +x ${RAAT_APP} && \
[ -s uuid ] || /usr/bin/uuidgen > uuid

# used fixed volume for digi cards
sed -i 's/DIGIFIXED=0/DIGIFIXED=1/' configure-raat

./${CONFIGURE_RAAT}

exec setpriv --reuid=nobody --regid=${AUDIO_GROUP} --init-groups ./${RAAT_APP} hifiberry_raat.conf
