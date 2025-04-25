FROM ubuntu:24.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y --no-install-recommends ubuntu-server
RUN apt-get install -y --no-install-recommends ubuntu-standard
RUN apt-get install -y --no-install-recommends libatomic1
RUN apt-get install -y --no-install-recommends sudo
RUN apt-get install -y --no-install-recommends nano
RUN apt-get install -y --no-install-recommends curl
RUN apt-get install -y --no-install-recommends adduser

RUN apt-get update && \
    dpkg --add-architecture i386 && \
    # Pre-acepta la licencia de SteamCMD
    echo steam steam/license note '' | debconf-set-selections && \
    echo steam steam/question select "I AGREE" | debconf-set-selections && \
    # Actualiza de nuevo para obtener las listas de paquetes i386
    apt-get update && \
    # Instala los paquetes necesarios (sin sudo)
    apt-get install -y --no-install-recommends \
        bc \
        binutils \
        bsdmainutils \
        bzip2 \
        cpio \
        distro-info \
        file \
        jq \
        lib32gcc-s1 \
        lib32stdc++6 \
        libsdl2-2.0-0:i386 \
        netcat-openbsd \
        pigz \
        python3 \
        steamcmd \
        tmux \
        unzip \
        uuid-runtime \
        wget \
        xz-utils

RUN rm -rf /var/lib/apt/lists/*

RUN adduser --disabled-password --gecos "" ets2server
COPY ets2server /home/ets2server/ets2server
RUN chown ets2server:ets2server /home/ets2server/ets2server
RUN chmod +x /home/ets2server/ets2server

USER ets2server
WORKDIR /home/ets2server

RUN ./ets2server ai