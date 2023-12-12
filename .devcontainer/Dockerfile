# dependencies
FROM docker.io/cloudflare/cloudflared:2023.10.0 as cloudflared
FROM docker.io/fluxcd/flux-cli:v2.2.0 as flux
FROM docker.io/alpine/helm:3.13.2 as helm
FROM docker.io/kopia/kopia:20231211.0.183046 as kopia
FROM docker.io/bitnami/kubectl:1.28.4 as kubectl
FROM docker.io/hashicorp/vault:1.15.4 as vault
FROM docker.io/mikefarah/yq:4.40.5 as yq

# base image
FROM docker:24.0.7-dind-rootless

ENV EDITOR=nano \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

USER root

# install persisted devcontainer dependencies
RUN apk --update --no-cache add \
    ansible \
    ansible-lint \
    apache2-utils \
    bash \
    build-base \
    ca-certificates \
    curl \
    docker \
    gettext \
    git \
    git-crypt \
    gnupg \
    jq \
    libffi-dev \
    libintl \
    nano \
    py-netaddr \
    openssh-client \
    openssl \
    openssl-dev \
    py-cryptography \
    python3 \
    python3-dev \
    py3-pip \
    restic \
    rsync \
    shadow \
    shellcheck \
    sshpass \
    sudo \
    unzip \
    zsh

COPY pip-requirements.txt ansible-requirements.yml /tmp/
RUN pip3 install --no-cache-dir --requirement /tmp/pip-requirements.txt && \
    ansible-galaxy install -r /tmp/ansible-requirements.yml

# install binary releases
COPY binary-releases.sh /tmp/binary-releases.sh
RUN /tmp/binary-releases.sh

COPY --from=cloudflared /usr/local/bin/cloudflared       /usr/local/bin/cloudflared
COPY --from=flux        /usr/local/bin/flux              /usr/local/bin/flux
COPY --from=helm        /usr/bin/helm                    /usr/local/bin/helm
COPY --from=kopia       /usr/bin/kopia                   /usr/local/bin/kopia
COPY --from=kubectl     /opt/bitnami/kubectl/bin/kubectl /usr/local/bin/kubectl
COPY --from=vault       /bin/vault                       /usr/local/bin/vault
COPY --from=yq          /usr/bin/yq                      /usr/local/bin/yq

# gcloud
RUN wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-444.0.0-linux-x86_64.tar.gz \
    -O /tmp/google-cloud-sdk.tar.gz | bash && \
    mkdir -p /usr/local/gcloud \
    && tar -C /usr/local/gcloud -xvzf /tmp/google-cloud-sdk.tar.gz \
    && /usr/local/gcloud/google-cloud-sdk/install.sh -q

# Setup user/profile
RUN mkdir -p /etc/sudoers.d && \
    echo rootless ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/rootless && \
    chmod 0440 /etc/sudoers.d/rootless && \
    usermod --shell /bin/zsh rootless

COPY --chown=rootless .zshrc /home/rootless
RUN git clone --single-branch --depth 1 https://github.com/robbyrussell/oh-my-zsh.git /home/rootless/.oh-my-zsh > /dev/null && \
    rm -rf /home/rootless/.oh-my-zsh/.git && \
    chown -R rootless:1000 /home/rootless/.oh-my-zsh && \
    chmod -R 700 /home/rootless/.oh-my-zsh && \
    cp -R /root/.ansible /home/rootless && chown -R rootless:1000 /home/rootless && \
    rm -rf /var/cache/apk/*

WORKDIR /home/rootless
USER rootless

RUN helm plugin install https://github.com/databus23/helm-diff

ENV DOCKER_HOST=unix:///var/run/user/1000/docker.sock
ENV PATH="${PATH}:/usr/local/gcloud/google-cloud-sdk/bin/"

HEALTHCHECK NONE
