#!/usr/bin/env zsh

export TASK_VERSION=v3.30.1
curl -fsSL "https://github.com/go-task/task/releases/download/${TASK_VERSION}/task_linux_amd64.tar.gz" \
    | tar xvz --overwrite --file - --directory /tmp
mv /tmp/task /usr/local/bin/task
task --version

export CILIUM_VERSION=v0.15.8
curl -fsSL "https://github.com/cilium/cilium-cli/releases/download/${CILIUM_VERSION}/cilium-linux-amd64.tar.gz" \
    | tar xvz --overwrite --file - --directory /tmp
mv /tmp/cilium /usr/local/bin/cilium

export HUBBLE_VERSION="v0.12.0"
curl -fsSL "https://github.com/cilium/hubble/releases/download/${HUBBLE_VERSION}/hubble-linux-amd64.tar.gz" \
    | tar xvz --overwrite --file - --directory /tmp
mv /tmp/hubble /usr/local/bin/hubble

export TETRA_VERSION="v0.11.0"
curl -fsSL "https://github.com/cilium/tetragon/releases/download/${TETRA_VERSION}/tetra-linux-amd64.tar.gz" \
    | tar xvz --overwrite --file - --directory /tmp
mv /tmp/tetra /usr/local/bin/tetra

export GITOPS_VERSION="v0.32.0"
curl -fsSL "https://github.com/weaveworks/weave-gitops/releases/download/${GITOPS_VERSION}/gitops-Linux-x86_64.tar.gz" \
    | tar xvz --overwrite --file - --directory /tmp
mv /tmp/gitops /usr/local/bin/gitops

export DYFF_VERSION="1.5.8"
curl -fsSL "https://github.com/homeport/dyff/releases/download/v${DYFF_VERSION}/dyff_${DYFF_VERSION}_linux_amd64.tar.gz" \
    | tar xvz --overwrite --file - --directory /tmp
mv /tmp/dyff /usr/local/bin/dyff

export DIRENV_VERSION="v2.32.3"
curl https://github.com/direnv/direnv/releases/download/${DIRENV_VERSION}/direnv.linux-amd64 \
  -o /usr/local/bin/direnv && \
  chmod +x /usr/local/bin/direnv

export K9S_VERSION="v0.28.0"
curl -fsSL https://github.com/derailed/k9s/releases/download/${K9S_VERSION}/k9s_Linux_amd64.tar.gz \
    | tar xvz --overwrite --file - --directory /tmp
mv /tmp/k9s /usr/local/bin/k9s

curl https://dl.min.io/client/mc/release/linux-amd64/mc \
  -o /usr/local/bin/mc && \
  chmod +x /usr/local/bin/mc

rm -rf /tmp/*
