#!/usr/bin/env zsh

export TASK_VERSION=v3.23.0
curl -fsSL "https://github.com/go-task/task/releases/download/${TASK_VERSION}/task_linux_amd64.tar.gz" \
    | tar xvz --overwrite --file - --directory /tmp
mv /tmp/task /usr/local/bin/task
task --version

export CILIUM_VERSION=v0.13.2
curl -fsSL "https://github.com/cilium/cilium-cli/releases/download/${CILIUM_VERSION}/cilium-linux-amd64.tar.gz" \
    | tar xvz --overwrite --file - --directory /tmp
mv /tmp/cilium /usr/local/bin/cilium

export HUBBLE_VERSION="v0.11.3"
curl -fsSL "https://github.com/cilium/hubble/releases/download/${HUBBLE_VERSION}/hubble-linux-amd64.tar.gz" \
    | tar xvz --overwrite --file - --directory /tmp
mv /tmp/hubble /usr/local/bin/hubble

export TETRA_VERSION="v0.9.0"
curl -fsSL "https://github.com/cilium/tetragon/releases/download/${TETRA_VERSION}/tetra-linux-amd64.tar.gz" \
    | tar xvz --overwrite --file - --directory /tmp
mv /tmp/tetra /usr/local/bin/tetra

export S5CMD_VERSION="2.1.0"
curl -fsSL "https://github.com/peak/s5cmd/releases/download/v${S5CMD_VERSION}/s5cmd_${S5CMD_VERSION}_Linux-64bit.tar.gz" \
    | tar xvz --overwrite --file - --directory /tmp
mv /tmp/s5cmd /usr/local/bin/s5cmd

rm -rf /tmp/*
