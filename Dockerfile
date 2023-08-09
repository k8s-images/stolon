
# --- Aliases for official images

FROM docker.io/library/postgres:13.11@sha256:538cb8a80fbb8da5275d7e1564da9413357a47dc2b0f8803708bafe3bcece1e8 AS postgres
FROM docker.io/sorintlab/stolon:v0.17.0-pg13@sha256:7a6e890392f2fa787fa136408bbf757d4c7deb6230efc07b773b35f323685103 AS sorintlab-stolon
FROM docker.io/library/busybox:1.36.1@sha256:023917ec6a886d0e8e15f28fb543515a5fcd8d938edb091e8147db4efed388ee AS builder

# --- Scripts

FROM builder AS stolon

WORKDIR /install

COPY --chown=root:root include/start-keeper.sh /install/start-keeper
COPY --chown=root:root include/stop-keeper.sh /install/stop-keeper

RUN chmod 0755 start-keeper stop-keeper

COPY --from=sorintlab-stolon /usr/local/bin/stolon-sentinel /install/stolon-sentinel
COPY --from=sorintlab-stolon /usr/local/bin/stolon-proxy /install/stolon-proxy
COPY --from=sorintlab-stolon /usr/local/bin/stolon-keeper /install/stolon-keeper
COPY --from=sorintlab-stolon /usr/local/bin/stolonctl /install/stolonctl

RUN set -eux \
  \
  ; /install/stolon-sentinel --version \
  ; /install/stolon-proxy --version \
  ; /install/stolonctl --version \
  \
  ; mkdir -p /install/keeper \
  ; mv -vf /install/start-keeper /install/keeper/start-keeper \
  ; mv -vf /install/stop-keeper /install/keeper/stop-keeper \
  ; mv -vf /install/stolon-keeper /install/keeper/stolon-keeper \
  ; cp -vf /install/stolonctl /install/keeper/stolonctl \
  ; /install/keeper/stolonctl --version \
  ; /install/keeper/stolon-keeper --version

ADD https://github.com/wal-g/wal-g/releases/download/v2.0.1/wal-g-gp-ubuntu-18.04-amd64 /install/keeper/wal-g

RUN set -eux \
  ; chmod 0755 /install/keeper/wal-g \
  ; chown root:root /install/keeper/wal-g \
  ; /install/keeper/wal-g --version

# --- Base

FROM scratch AS empty

LABEL org.opencontainers.image.source https://github.com/k8s-images/stolon

# --- Sentinel

FROM empty AS sentinel

COPY --from=stolon /install/stolon-sentinel /stolon-sentinel

USER 1042:1042

ENV STSENTINEL_LOG_COLOR="0" \
    STSENTINEL_STORE_BACKEND="kubernetes" \
    STSENTINEL_KUBE_RESOURCE_KIND="configmap" \
    STSENTINEL_METRICS_LISTEN_ADDRESS="0.0.0.0:9001" \
    STSENTINEL_CLUSTER_NAME="k8s-ha"

EXPOSE 9001

ENTRYPOINT ["/stolon-sentinel"]

# --- Proxy

FROM empty AS proxy

COPY --from=stolon /install/stolon-proxy /stolon-proxy

USER 1042:1042

ENV STPROXY_PORT="5432" \
    STPROXY_LOG_COLOR="0" \
    STPROXY_STORE_BACKEND="kubernetes" \
    STPROXY_KUBE_RESOURCE_KIND="configmap" \
    STPROXY_LISTEN_ADDRESS="0.0.0.0" \
    STPROXY_METRICS_LISTEN_ADDRESS="0.0.0.0:9002" \
    STPROXY_CLUSTER_NAME="k8s-ha"

EXPOSE 5432 9002

ENTRYPOINT ["/stolon-proxy"]

# --- Stolon CLI

FROM empty AS stolonctl

COPY --from=stolon /install/stolonctl /stolonctl

USER 1042:1042

ENV STOLONCTL_STORE_BACKEND="kubernetes" \
    STOLONCTL_KUBE_RESOURCE_KIND="configmap" \
    STOLONCTL_CLUSTER_NAME="k8s-ha"

ENTRYPOINT ["/stolonctl"]
CMD ["--help"]

# --- Postgres base

FROM postgres AS postgres-base

# hadolint ignore=DL3008
RUN set -eux \
  \
  ; apt-get -qq update \
  ; apt-get -qq --no-install-recommends install \
            dnsutils \
            jq \
  ; rm -rf /var/cache/apt/* \
           /var/lib/apt/* \
  \
  ; dig -v \
  ; jq --version

# --- Keeper

FROM postgres-base AS keeper

LABEL org.opencontainers.image.source https://github.com/k8s-images/stolon

COPY --from=stolon /install/keeper /usr/local/bin

RUN set -eux \
  \
  ; wal-g --version \
  ; stolon-keeper --version \
  ; stolonctl --version \
  \
  ; useradd \
    --comment "Stolon Keeper" \
    --create-home \
    --uid 1042 \
    --shell /bin/bash \
    stolon \
  \
  ; mkdir -p /data \
  ; chown 1042:1042 /data \
  ; chmod 0700 /data

USER 1042:1042

ENV PGDATA="/data" \
    STOLON_DATA="/data" \
    STKEEPER_DATA_DIR="/data" \
    STKEEPER_STORE_BACKEND="kubernetes" \
    STKEEPER_KUBE_RESOURCE_KIND="configmap" \
    STKEEPER_METRICS_LISTEN_ADDRESS="0.0.0.0:9003" \
    STKEEPER_LOG_COLOR="0" \
    STKEEPER_PG_PORT="6432" \
    STKEEPER_CLUSTER_NAME="k8s-ha" \
    STOLONCTL_STORE_BACKEND="kubernetes" \
    STOLONCTL_KUBE_RESOURCE_KIND="configmap" \
    STOLONCTL_CLUSTER_NAME="k8s-ha"

EXPOSE 6432 9003

VOLUME ["/data"]

ENTRYPOINT ["start-keeper"]
CMD ["--data-dir", "/data"]

# --- Postgres Client Utils

FROM postgres-base AS postgres-utils

LABEL org.opencontainers.image.source https://github.com/k8s-images/stolon

COPY --chown=root:root include/postgres-utils-entrypoint.sh /entrypoint

RUN set -eux \
  ; useradd \
    --comment "Postgres Client" \
    --create-home \
    --uid 1042 \
    --shell /bin/bash \
    k8s \
  ; rm -f /home/k8s/.bash_logout \
          /home/k8s/.bash_history \
  \
  ; chmod 0755 /entrypoint

USER 1042:1042

ENTRYPOINT ["/entrypoint"]
CMD ["--help"]
