# Use Ubuntu 22.04 as the base image
FROM nvidia/cuda:12.6.1-devel-ubuntu22.04

# Set non-interactive mode for apt
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary dependencies
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    binutils-dev \
    libseccomp-dev \
    pkg-config \
    squashfs-tools \
    libarchive-dev \
    wget \
    vim \
    python3 \
    python3-pip \
    python3-venv \
    gfortran \
    libopenmpi-dev \
    gawk \
    curl \
    git && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/spack/spack.git && \
    cd spack && \
    git checkout v0.22.2

COPY spack.yaml .

#RUN cd spack && \
#    . share/spack/setup-env.sh && \
#    spack env create spackenv ../spack.yaml && \
#    spack env activate -p spackenv && \
#    spack external find && \
#    spack install

# Set the default command
CMD ["/bin/bash"]

