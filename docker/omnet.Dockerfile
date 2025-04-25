FROM ubuntu:22.04 AS build
RUN apt-get update && apt-get install -y build-essential cmake gcc g++ tcl-dev tk-dev libxml2-dev libgtk2.0-dev libopenmpi-dev openmpi-bin git wget python3 python3-pip && rm -rf /var/lib/apt/lists/*
ARG OMNET_VER=6.0
RUN wget -q https://github.com/omnetpp/omnetpp/releases/download/v${OMNET_VER}/omnetpp-${OMNET_VER}-src.tgz \
    && tar -xf omnetpp-${OMNET_VER}-src.tgz && cd omnetpp-${OMNET_VER} \
    && ./configure WITH_TKENV=no && make -j$(nproc)
ENV PATH="/omnetpp-${OMNET_VER}/bin:$PATH"
ARG INET_COMMIT=v4.4.0
RUN git clone --depth 1 --branch ${INET_COMMIT} https://github.com/inet-framework/inet.git \
    && cd inet && make makefiles && make -j$(nproc)
ARG SIMU5G_COMMIT=e29c3de
RUN git clone --depth 1 https://github.com/Unipisa/Simu5G.git \
    && cd Simu5G && git checkout ${SIMU5G_COMMIT} \
    && export INET_DIR=/inet && make -j$(nproc)
FROM ubuntu:22.04
COPY --from=build /omnetpp-6.0 /omnetpp-6.0
COPY --from=build /inet /inet
COPY --from=build /Simu5G /Simu5G
ENV PATH="/omnetpp-6.0/bin:/inet/src:/Simu5G/bin:$PATH"
WORKDIR /workspace
