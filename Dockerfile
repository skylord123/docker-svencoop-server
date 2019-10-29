FROM debian:stable-slim
FROM i386/debian:stretch-slim

MAINTAINER skylord123

RUN dpkg --add-architecture i386 && \
    apt-get update && apt-get install --no-install-recommends -y \
        wget curl ca-certificates libgcc1 libstdc++6 libssl1.1:i386 libstdc++6:i386 locales locales-all zlib1g:i386 libc6 libstdc++6 ca-certificates libgcc1 libstdc++6:i386 zlib1g:i386 curl file bzip2 gzip unzip libssl1.1:i386 libxrandr-dev:i386 libxi-dev:i386 libgl1-mesa-glx:i386 libxtst6:i386 libusb-1.0.0:i386 libxxf86vm1:i386 libglu1-mesa:i386 libopenal1:i386 libgtk2.0-0:i386 libsm6:i386 libdbus-glib-1-2:i386 libnm-glib4:i386 libnm-util2:i386 libudev-dev:i386 libudev-dev libpulse0 && \
    apt-get clean && \
    echo "LC_ALL=en_US.UTF-8" >> /etc/environment && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/* && \
    ln -s /lib/i386-linux-gnu/libudev.so.1 /lib/i386-linux-gnu/libudev.so.0

ENV LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8
ENV DATA_DIR="/serverdata"
ENV STEAMCMD_DIR="${DATA_DIR}/steamcmd"
ENV SERVER_DIR="${DATA_DIR}/serverfiles"
ENV GAME_ID="276060"
ENV GAME_NAME="svencoop"
ENV GAME_PARAMS="template"
ENV GAME_PORT=27015
ENV VALIDATE=""
ENV UID=99
ENV GID=100
ENV USERNAME=""
ENV PASSWRD=""

ADD /scripts/ /opt/scripts/
RUN mkdir $DATA_DIR && \
    mkdir $STEAMCMD_DIR && \
    mkdir $SERVER_DIR && \
    useradd -d $DATA_DIR -s /bin/bash --uid $UID --gid $GID steam && \
    chown -R steam $DATA_DIR && \
    ulimit -n 2048 && \
    chmod -R 770 /opt/scripts/ && \
    chown -R steam /opt/scripts

USER steam

#Server Start
ENTRYPOINT ["/opt/scripts/start-server.sh"]
