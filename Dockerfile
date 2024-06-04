FROM debian:stable-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
                    curl \
                    ca-certificates \
                    sox \
                    uuid-runtime \
                    alsa-utils \
                    libglib2.0-bin \
                    libasound2 && \
    rm -rf /var/lib/apt/lists/*

ENV HIFIBERRY_BASE_URL https://github.com/hifiberry/hifiberry-os/raw/master/buildroot/package/raat
ENV CONFIGURE_RAAT configure-raat
ENV RAAT_APP raat_app.aarch64
ENV ALSA_CARD=sndrpihifiberry

# 29 is the audio group on the host
ENV AUDIO_GROUP=29

ADD entrypoint.sh /

RUN mkdir -p /raat && \
    echo 20200527 > /etc/hifiberry.version && \    
    echo 'CURRENT_MIXER_CONTROL="Digital"' > /etc/hifiberry.state && \
    echo > /raat/hifiberry_raat.conf && \
    ln -s /raat/hifiberry_raat.conf /etc/hifiberry_raat.conf && \
    touch /raat/uuid && \
    ln -s /raat/uuid /etc/uuid


ENV HOME /raat
WORKDIR /raat
VOLUME /raat
CMD ["/bin/bash", "-c", "/entrypoint.sh"]
