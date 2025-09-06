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

RUN adduser --disabled-password --gecos "" atsserver
WORKDIR /home/atsserver

COPY config_ds.cfg config_ds.cfg
COPY server_config.sii server_config.sii
COPY entrypoint.sh entrypoint.sh
COPY atsserver atsserver

RUN chmod +x entrypoint.sh
RUN chmod +x atsserver

RUN chown -R atsserver:atsserver config_ds.cfg
RUN chown -R atsserver:atsserver server_config.sii
RUN chown -R atsserver:atsserver atsserver

RUN echo '*/5 * * * * atsserver /home/atsserver/atsserver monitor > /dev/null 2>&1' > /etc/cron.d/ats-monitor
RUN chmod 0644 /etc/cron.d/ats-monitor
RUN chown root:root /etc/cron.d/ats-monitor
RUN echo "" >> /etc/cron.d/ats-monitor

USER atsserver
RUN ./atsserver ai

USER root
RUN rm -rf "./local/American Truck Simulator"
ENTRYPOINT ["/home/atsserver/entrypoint.sh"]