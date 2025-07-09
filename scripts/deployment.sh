#!/bin/bash

set -e
log_file="deployment_log.md"
exec > >(tee -a "$log_file") 2>&1

# install Docker if not installed, then start containers
install_and_run_app() {
  echo "🔧 Connecting and setting up Docker..."

  if ! command -v docker &>/dev/null; then
    echo "Installing Docker..."
    sudo apt-get update
    sudo apt-get install -y ca-certificates curl gnupg
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor --batch -o /etc/apt/keyrings/docker.gpg
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
  else
    echo "Docker is already installed."
  fi

  if ! docker compose version &>/dev/null; then
    echo "Installing Docker Compose..."
     sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    sudo apt-get install -y docker-compose-plugin
  else
    echo "Docker Compose is already installed."
  fi

  echo "Running Docker Compose..."
  cd /home/adminuser/app
  sudo docker compose down || true
  sudo docker compose up -d --build
}

main() {
  install_and_run_app
  echo "Deployment completed!"
}

main
