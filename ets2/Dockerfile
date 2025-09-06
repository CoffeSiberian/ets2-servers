FROM ubuntu:24.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    ubuntu-server \
    libatomic1 \
    sudo \
    nano \
    curl \
    adduser \
    && rm -rf /var/lib/apt/lists/*

RUN dpkg --add-architecture i386 && \
    echo steam steam/license note '' | debconf-set-selections && \
    echo steam steam/question select "I AGREE" | debconf-set-selections && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        bc binutils bsdmainutils bzip2 cpio distro-info file jq \
        lib32gcc-s1 lib32stdc++6 libsdl2-2.0-0:i386 libx11-6 \
        netcat-openbsd pigz python3 steamcmd tmux unzip \
        uuid-runtime wget xz-utils \
    && rm -rf /var/lib/apt/lists/*

RUN adduser --disabled-password --gecos "" ets2server
WORKDIR /home/ets2server

COPY config_ds.cfg config_ds.cfg
COPY server_config.sii server_config.sii
COPY entrypoint.sh entrypoint.sh
COPY ets2server ets2server

RUN chmod +x entrypoint.sh
RUN chmod +x ets2server

RUN chown -R ets2server:ets2server config_ds.cfg
RUN chown -R ets2server:ets2server server_config.sii
RUN chown -R ets2server:ets2server ets2server

RUN echo '*/5 * * * * ets2server /home/ets2server/ets2server monitor > /dev/null 2>&1' > /etc/cron.d/ets2-monitor
RUN chmod 0644 /etc/cron.d/ets2-monitor
RUN chown root:root /etc/cron.d/ets2-monitor
RUN echo "" >> /etc/cron.d/ets2-monitor

USER ets2server
RUN ./ets2server ai

USER root
RUN rm -rf "./local/Euro Truck Simulator 2"
ENTRYPOINT ["/home/ets2server/entrypoint.sh"]