FROM ubuntu:24.04

ARG REMOTE_USER
ARG REMOTE_UID
ARG REMOTE_GID

ARG gcc_release=12.3.rel1
ARG gcc_variant=arm-none-eabi
ARG arch=x86_64

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
      build-essential \
      git \
      bzip2 \
      wget \
      cmake \
      ninja-build \
      python3

RUN <<EOF
    userdel -r ubuntu
    addgroup --gid ${REMOTE_GID} ${REMOTE_USER}
    adduser --disabled-password --uid ${REMOTE_UID} --gid ${REMOTE_GID} ${REMOTE_USER}
EOF

ENV HOME=/home/${REMOTE_USER}

USER ${REMOTE_USER}

# Install the specific GCC toolchain
WORKDIR /workspaces
RUN wget -qO- https://developer.arm.com/-/media/Files/downloads/gnu/${gcc_release}/binrel/arm-gnu-toolchain-${gcc_release}-${arch}-${gcc_variant}.tar.xz | tar -xJ
ENV PATH="/workspaces/arm-gnu-toolchain-${gcc_release}-${arch}-${gcc_variant}/bin:$PATH"

# Install the MetaModule SDK
RUN git clone https://github.com/4ms/metamodule-plugin-sdk --recursive