FROM ubuntu@sha256:b58746c8a89938b8c9f5b77de3b8cf1fe78210c696ab03a1442e235eea65d84f
LABEL maintainer="hotio"

ARG DEBIAN_FRONTEND="noninteractive"

ENTRYPOINT ["borg"]

ARG BORG_VERSION

# install
RUN apt update && \
    apt install -y --no-install-recommends --no-install-suggests \
        fuse python3 python3-pkg-resources libssl1.1 libacl1 \
        libfuse-dev python3-pip python3-setuptools build-essential python3-all-dev libssl-dev libacl1-dev && \
    pip3 install --no-cache-dir --upgrade borgbackup[fuse]==${BORG_VERSION} && \
# clean up
    apt purge -y libfuse-dev python3-pip python3-setuptools build-essential python3-all-dev libssl-dev libacl1-dev && \
    apt autoremove -y && \
    apt clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*
