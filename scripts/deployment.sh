#!/bin/bash

set -e
log_file="deployment_log.md"
exec > >(tee -a "$log_file") 2>&1

REMOTE_USER="adminuser"
SSH_KEY_PATH="$HOME/.ssh/terraform"

# Check if public IP was passed as argument
if [ -z "$1" ]; then
  echo "Usage: $0 <public_ip_address>"
  exit 1
fi

PUBLIC_IP="$1"

echo "Starting deployment on $PUBLIC_IP"

# Step 1: Transfer application files to remote VM
transfer_files() {
  echo "Transferring files to $REMOTE_USER@$PUBLIC_IP..."
  scp -i "$SSH_KEY_PATH" -r ./app "$REMOTE_USER@$PUBLIC_IP:/home/$REMOTE_USER/app"
}

# Step 2: Connect to VM and install Docker if not installed, then start containers
install_and_run_app() {
  echo "🔧 Connecting and setting up Docker..."
  ssh -i "$SSH_KEY_PATH" "$REMOTE_USER@$PUBLIC_IP" << 'EOF'
    set -e
    echo "Connected to $(hostname)"

    if ! command -v docker &> /dev/null; then
      echo "Installing Docker..."
      sudo apt-get update
      sudo apt-get install -y ca-certificates curl gnupg
      sudo install -m 0755 -d /etc/apt/keyrings
      curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
      echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
      sudo apt-get update
      sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    else
      echo "Docker is already installed."
    fi

    echo "Checking Docker Compose..."
    if ! docker compose version &> /dev/null; then
      echo "Docker Compose is missing or broken!"
      exit 1
    fi

    echo "Running Docker Compose..."
    cd /home/adminuser/app
    sudo docker compose down || true
    sudo docker compose up -d --build
EOF
}

main() {
  transfer_files
  install_and_run_app
  echo "Deployment completed!"
}

main
