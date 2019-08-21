FROM debian:stable-slim
MAINTAINER kiril@phrontizo.com

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
                    wget \
                    bzip2 \
                    ffmpeg \
                    cifs-utils \
                    alsa-utils \
                    libasound2 && \
    rm -rf /var/lib/apt/lists/*

ENV ROON_BRIDGE_FILENAME RoonBridge_linuxarmv7hf.tar.bz2
ENV ROON_BRIDGE_URL http://download.roonlabs.com/builds/${ROON_BRIDGE_FILENAME}

# 63 is the audio group on the host
ENV ROON_USER 1000:63
ENV ROON_DATAROOT /var/roon

ADD entrypoint.sh /

RUN mkdir -p /roon && \
    mkdir -p ${ROON_DATAROOT} && \
    chown ${ROON_USER} /roon && \
    chown ${ROON_USER} ${ROON_DATAROOT}

ENV HOME /roon
WORKDIR /roon
USER ${ROON_USER}
VOLUME ${ROON_DATAROOT}
ENTRYPOINT /entrypoint.sh
