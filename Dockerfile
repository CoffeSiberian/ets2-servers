FROM ubuntu:24.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      ubuntu-server \
      ubuntu-standard \
      libatomic1 \
 && rm -rf /var/lib/apt/lists/*