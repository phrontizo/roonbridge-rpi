FROM debian:stable-slim
MAINTAINER kiril@phrontizo.com

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
                    wget \
                    ca-certificates \
                    sox \
                    uuid-runtime \
                    alsa-utils \
                    libglib2.0-bin \
                    libasound2 && \
    rm -rf /var/lib/apt/lists/*

ENV HIFIBERRY_BASE_URL https://github.com/hifiberry/hifiberry-os/raw/master/buildroot/package/raat
ENV CONFIGURE_RAAT configure-raat
ENV RAAT_APP raat_app

# 63 is the audio group on the host
ENV RAAT_USER 1000:63

ADD entrypoint.sh /

RUN mkdir -p /raat && \
    chown ${RAAT_USER} /raat && \
    echo 20200527 > /etc/hifiberry.version && \    
    echo 'CURRENT_MIXER_CONTROL="Digital"' > /etc/hifiberry.state && \
    echo > /raat/hifiberry_raat.conf && \
    chown ${RAAT_USER} /raat/hifiberry_raat.conf && \
    ln -s /raat/hifiberry_raat.conf /etc/hifiberry_raat.conf && \
    touch /raat/uuid && \
    chown ${RAAT_USER} /raat/uuid && \
    ln -s /raat/uuid /etc/uuid


ENV HOME /raat
WORKDIR /raat
USER ${RAAT_USER}
VOLUME /raat
ENTRYPOINT /entrypoint.sh
