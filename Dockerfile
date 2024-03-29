FROM ubuntu:latest AS base

RUN apt-get update && apt-get install -y \
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
    python3-pip

# Build neovim (and use it as an example codebase)
RUN git clone https://github.com/neovim/neovim.git

ARG VERSION=master
RUN cd neovim && git checkout ${VERSION} && make CMAKE_BUILD_TYPE=RelWithDebInfo install

# To support kickstart.nvim
RUN apt-get install -y \
    fd-find \
    universal-ctags \
    ripgrep

RUN npm i -g neovim

RUN pip install pynvim

WORKDIR /root/.config/nvim
