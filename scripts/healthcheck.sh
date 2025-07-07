#!/bin/bash

# Simple health check script
VM_IP="$1"
PORT=3000

if [ -z "$VM_IP" ]; then
  echo "Usage: $0 <vm-public-ip>"
  exit 1
fi

if curl -s --head "http://$VM_IP:$PORT" | grep "200 OK" > /dev/null; then
  echo "App is up and reachable on $VM_IP:$PORT"
else
  echo "App is NOT reachable. Please check deployment or NSG settings."
fi
