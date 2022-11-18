# [Choice] Python version (use -bullseye variants on local arm64/Apple Silicon): 3, 3.10, 3.9, 3.8, 3.7, 3.6, 3-bullseye, 3.10-bullseye, 3.9-bullseye, 3.8-bullseye, 3.7-bullseye, 3.6-bullseye, 3-buster, 3.10-buster, 3.9-buster, 3.8-buster, 3.7-buster, 3.6-buster
ARG VARIANT=3.10-bullseye
FROM mcr.microsoft.com/vscode/devcontainers/python:${VARIANT}

ARG NODE_VERSION=16
ARG CLOUD_SDK_VERSION=409.0.0
ENV CLOUD_SDK_VERSION=$CLOUD_SDK_VERSION
ENV PYTHONUNBUFFERED 1
ENV PATH "$PATH:/opt/google-cloud-sdk/bin/"

# Install Google Cloud SDK
RUN apt-get update -y && export DEBIAN_FRONTEND=noninteractive \
  && apt-get -y install --no-install-recommends \
  curl \
  python3-dev \
  python3-crcmod \
  apt-transport-https \
  default-jre \
  lsb-release \
  openssh-client \
  git \
  make \
  gnupg \
  && export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" \
  && echo "deb https://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" > /etc/apt/sources.list.d/google-cloud-sdk.list \
  && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
  && apt-get update -y \
  && apt-get install -y google-cloud-sdk=${CLOUD_SDK_VERSION}-0 google-cloud-sdk-app-engine-python=${CLOUD_SDK_VERSION}-0 google-cloud-sdk-app-engine-python-extras=${CLOUD_SDK_VERSION}-0 \
  && gcloud --version

# Install GCP container registry credential helper
RUN pip3 install pyopenssl && \ 
  git config --system credential.'https://source.developers.google.com'.helper gcloud.sh

# Switch into VSCode user
USER vscode


# Specify volume to persist config (GCloud and Firebase SDK authentication)
RUN mkdir /home/vscode/.config
VOLUME "/home/vscode/.config"

# [Choice] Node.js version: none, lts/*, 16, 14, 12, 10
RUN umask 0002 && . /usr/local/share/nvm/nvm.sh && nvm install ${NODE_VERSION} 2>&1

# Install Firebase SDK/CLI
RUN npm i -g firebase-tools

WORKDIR /workspace

# Firebase emulator UI
EXPOSE 4000
# Firestore
EXPOSE 8080
# Firebase Auth
EXPOSE 9099

# SDK auth servers
EXPOSE 8085
EXPOSE 9005