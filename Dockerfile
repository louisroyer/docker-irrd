FROM debian:bookworm-slim

ARG IRRD_VERSION=4.4.0


RUN apt-get update \
 && apt-get install -y build-essential gcc gnupg libpq-dev dumb-init python3 python3-pip python3-dev python3-venv \
 && python3 -m venv /env && /env/bin/pip install --no-cache-dir irrd==$IRRD_VERSION \
 && apt-get clean autoclean \
 && apt-get autoremove -y \
 && rm -rf /var/lib/apt/lists/*
COPY run.sh /opt/irrd/run

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["/opt/irrd/run"]
