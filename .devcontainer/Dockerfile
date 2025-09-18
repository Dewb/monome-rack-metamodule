FROM ubuntu:24.04

ARG METAMODULE_SDK_REF=d11a6d7c8d2373629f9466ed3c3c2f6a838ba2eb 
ARG METAMODULE_REF=firmware-v2.1.0

ARG gcc_release=12.3.rel1
ARG gcc_variant=arm-none-eabi
ARG arch=x86_64

ARG REMOTE_USER
ARG REMOTE_UID
ARG REMOTE_GID

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
      build-essential \
      git \
      bzip2 \
      wget \
      cmake \
      ninja-build \
      python3 \
      pkg-config \
      jq \
      libsdl2-dev

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

# Clone the MetaModule SDK at a specific commit/ref
WORKDIR /workspaces
RUN mkdir metamodule-plugin-sdk && \
    cd metamodule-plugin-sdk && \
    git init && \
    git remote add origin https://github.com/4ms/metamodule-plugin-sdk && \
    git fetch --depth=1 origin ${METAMODULE_SDK_REF} && \
    git reset --hard FETCH_HEAD && \
    git submodule update --init --recursive --depth 1

# Clone the MetaModule repo for the simulator code, also at a specific commit/ref
WORKDIR /workspaces
RUN mkdir metamodule && \
    cd metamodule && \
    git init && \
    git remote add origin https://github.com/4ms/metamodule && \
    git fetch --depth=1 origin ${METAMODULE_REF} && \
    git reset --hard FETCH_HEAD && \
    git submodule update --init --recursive --depth 1

WORKDIR /workspaces/metamodule 
RUN cat <<EOF > ext-plugins-preamble.txt
list(APPEND ext_builtin_brand_paths "\${CMAKE_CURRENT_LIST_DIR}/../../monome-rack-metamodule")
list(APPEND ext_builtin_brand_libname "MonomeMM")
list(APPEND ext_builtin_brand_slug "monome")
EOF
RUN mv simulator/ext-plugins.cmake simulator/ext-plugins.orig && \
    cat ext-plugins-preamble.txt simulator/ext-plugins.orig > simulator/ext-plugins.cmake
