FROM debian:stable-slim
MAINTAINER kiril@phrontizo.com

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
                    bzip2 \
                    ffmpeg \
                    cifs-utils \
                    alsa-utils \
                    libasound2 && \
    rm -rf /var/lib/apt/lists/*

ENV ROON_BRIDGE_URL http://download.roonlabs.com/builds/RoonBridge_linuxarmv7hf.tar.bz2
# 63 is the audio group on the host
ENV ROON_USER 1000:63
ENV ROON_DATAROOT /var/roon

ADD ${ROON_BRIDGE_URL} /install.tar.bz2

RUN tar xjf /install.tar.bz2 && \
    rm /install.tar.bz2 && \
    mkdir -p ${ROON_DATAROOT} && \
    chown ${ROON_USER} ${ROON_DATAROOT}

ENV HOME ${ROON_DATAROOT}
WORKDIR ${ROON_DATAROOT}
USER ${ROON_USER}
VOLUME ${ROON_DATAROOT}
ENTRYPOINT /RoonBridge/Bridge/RoonBridge
