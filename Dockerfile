FROM ubuntu:22.04 AS base

# Install build dependencies and runtime tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    autoconf \
    automake \
    build-essential \
    cmake \
    ninja-build \
    coreutils \
    curl \
    gettext \
    git \
    libtool \
    pkg-config \
    unzip \
    nodejs \
    npm \
    python3 \
    python3-pip \
    fd-find \
    universal-ctags \
    ripgrep \
    && rm -rf /var/lib/apt/lists/*

# Build neovim
ARG VERSION=master
RUN git clone --depth 1 --branch ${VERSION} https://github.com/neovim/neovim.git /tmp/neovim && \
    cd /tmp/neovim && \
    make CMAKE_BUILD_TYPE=RelWithDebInfo install && \
    cd / && \
    rm -rf /tmp/neovim

# Install neovim language server providers
RUN npm i -g neovim && \
    pip3 install --no-cache-dir pynvim

WORKDIR /root/.config/nvim

# Add labels for metadata
LABEL maintainer="Neovim Config"
LABEL description="Docker image with Neovim and common development tools"
LABEL version="1.0"
