#!/usr/bin/env zsh

export TASK_VERSION=v3.30.1
curl -fsSL "https://github.com/go-task/task/releases/download/${TASK_VERSION}/task_linux_amd64.tar.gz" \
    | tar xvz --overwrite --file - --directory /tmp
mv /tmp/task /usr/local/bin/task
task --version

export CILIUM_VERSION=v0.15.13
curl -fsSL "https://github.com/cilium/cilium-cli/releases/download/${CILIUM_VERSION}/cilium-linux-amd64.tar.gz" \
    | tar xvz --overwrite --file - --directory /tmp
mv /tmp/cilium /usr/local/bin/cilium

export CMCTL_VERSION=v1.12.7
curl -fsSL "https://github.com/cert-manager/cert-manager/releases/download/${CMCTL_VERSION}/cmctl-linux-amd64.tar.gz" \
    | tar xvz --overwrite --file - --directory /tmp
mv /tmp/cmctl /usr/local/bin/cmctl

export HUBBLE_VERSION="v0.12.2"
curl -fsSL "https://github.com/cilium/hubble/releases/download/${HUBBLE_VERSION}/hubble-linux-amd64.tar.gz" \
    | tar xvz --overwrite --file - --directory /tmp
mv /tmp/hubble /usr/local/bin/hubble

export TETRA_VERSION="v1.0.0"
curl -fsSL "https://github.com/cilium/tetragon/releases/download/${TETRA_VERSION}/tetra-linux-amd64.tar.gz" \
    | tar xvz --overwrite --file - --directory /tmp
mv /tmp/tetra /usr/local/bin/tetra

export DYFF_VERSION="1.5.8"
curl -fsSL "https://github.com/homeport/dyff/releases/download/v${DYFF_VERSION}/dyff_${DYFF_VERSION}_linux_amd64.tar.gz" \
    | tar xvz --overwrite --file - --directory /tmp
mv /tmp/dyff /usr/local/bin/dyff

export DIRENV_VERSION="v2.32.3"
curl https://github.com/direnv/direnv/releases/download/${DIRENV_VERSION}/direnv.linux-amd64 \
  -o /usr/local/bin/direnv && \
  chmod +x /usr/local/bin/direnv

curl https://dl.min.io/client/mc/release/linux-amd64/mc \
  -o /usr/local/bin/mc && \
  chmod +x /usr/local/bin/mc

rm -rf /tmp/*
