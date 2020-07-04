#!/bin/bash

wget ${HIFIBERRY_BASE_URL}/${CONFIGURE_RAAT}
wget ${HIFIBERRY_BASE_URL}/${RAAT_APP}
chmod +x ${CONFIGURE_RAAT} && \
chmod +x ${RAAT_APP} && \
[ -s /raat/uuid ] || /usr/bin/uuidgen > /raat/uuid
./${CONFIGURE_RAAT}

exec /raat/${RAAT_APP} /raat/hifiberry_raat.conf
