FROM ghcr.io/microsoft/airsim/ubuntu20:latest
RUN apt-get update && apt-get install -y python3 python3-pip && rm -rf /var/lib/apt/lists/*
RUN pip install zmq pyquaternion pandas
COPY scripts/airsim_bridge.py /usr/local/bin/airsim_bridge.py
ENTRYPOINT ["python3", "/usr/local/bin/airsim_bridge.py"]
