# syntax=docker/dockerfile:1
FROM docker.io/debian:trixie

ARG DEBIAN_FRONTEND="noninteractive"

ARG APP_UID="2000"
ARG APP_GID="2000"
ARG APP_USER="cursor"

RUN <<EOT
    set -o errexit && \
    apt-get update && \
    apt-get install --yes --no-install-recommends \
        bc \
        ca-certificates \
        curl \
        dnsutils \
        gh \
        git \
        jq \
        less \
        lsof \
        man-db \
        procps \
        psmisc \
        ripgrep \
        rsync \
        socat \
        unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
EOT

COPY --from=mikefarah/yq /usr/bin/yq /usr/bin/yq
COPY --from=denoland/deno:bin-2.6.4 /deno /usr/local/bin/deno

RUN \
    groupadd \
      --gid "${APP_GID}" "${APP_USER}" && \
    useradd \
      --gid "${APP_GID}" \
      --uid "${APP_UID}" \
      --comment "" \
      --shell /bin/bash \
      --create-home \
      "${APP_USER}"

WORKDIR /workspace

RUN chown --recursive "${APP_USER}:${APP_USER}" /workspace

USER "${APP_USER}"

RUN curl \
        --fail \
        --silent \
        --show-error \
        --follow \
        https://cursor.com/install | bash

ENV HOME="/home/${APP_USER}"
ENV PATH="${HOME}/.local/bin:${PATH}"

ENTRYPOINT ["agent"]
