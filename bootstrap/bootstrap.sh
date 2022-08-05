#!/bin/bash

#
# 1. Updating the environment
#
apt-get update -y
apt-get install -y \
            ca-certificates \
            curl \
            gnupg \
            lsb-release \
            vim \
            htop \
            make build-essential \
            libssl-dev zlib1g-dev \
            libbz2-dev libreadline-dev \
            libsqlite3-dev wget \
            curl llvm \
            libncursesw5-dev xz-utils tk-dev \
            libxml2-dev libxmlsec1-dev \
            libffi-dev \
            liblzma-dev \
            libcairo2-dev \
            postgresql-client-common \
            postgresql-client-12

#
# 2. Installing Docker
#

# 2.1. Download
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
  | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update -y
apt-get install docker-ce docker-ce-cli containerd.io -y

# 2.2. Configure the user to use Docker
groupadd docker
usermod -aG docker vagrant

#
# 3. Installing Docker Compose
#

# 3.1. Download
curl -L \
  "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/docker-compose

# 3.2. Make it executable
chmod +x /usr/local/bin/docker-compose

# 3.3. Linking it
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
