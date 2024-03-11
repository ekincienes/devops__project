#!/bin/bash

set -e

# sudo kullanimi kontrol
if [[ $EUID -ne 0 ]]; then
  echo "This script requires sudo. Please run it again with sudo."
  exit 1
fi

# docker yukluyse direkt exit atan script.
if command -v docker >/dev/null 2>&1; then
  echo "Docker sistemde halihazirda mevcuttur."
  docker version
  exit 0
fi

apt-get update

# docker icin gerekli gpg keyleri ve authorization islemleri
apt-get install -y apt-transport-https ca-certificates curl software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

apt-get update

# docker install etme islemi
apt-get install -y docker-ce

# docker sudo yetkisi islemleri
groupadd docker || true  # Suppress "groupadd: group docker already exists" message if applicable

usermod -aG docker $USER

# islem tamamlanmasi
echo "Docker is now installed. Please log out and log back in for the changes to take effect."
