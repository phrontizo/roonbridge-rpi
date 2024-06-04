#!/bin/bash

curl -sLO ${HIFIBERRY_BASE_URL}/${CONFIGURE_RAAT}
curl -sLO ${HIFIBERRY_BASE_URL}/${RAAT_APP}
chmod +x ${CONFIGURE_RAAT} && \
chmod +x ${RAAT_APP} && \
[ -s /raat/uuid ] || /usr/bin/uuidgen > /raat/uuid
./${CONFIGURE_RAAT}

exec setpriv --reuid=nobody --regid=${AUDIO_GROUP} --init-groups /raat/${RAAT_APP} /raat/hifiberry_raat.conf
