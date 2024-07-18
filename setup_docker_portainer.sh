#!/bin/bash

# Install Docker
echo "Updating the package list..."
sudo apt-get update

echo "Installing prerequisite packages..."
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

echo "Adding Docker’s official GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

echo "Adding Docker APT repository..."
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

echo "Updating the package database with Docker packages from the newly added repository..."
sudo apt-get update

echo "Installing Docker..."
sudo apt-get install -y docker-ce

echo "Starting Docker and enabling it to start at boot..."
sudo systemctl start docker
sudo systemctl enable docker

echo "Verifying Docker installation by running hello-world image..."
sudo docker run hello-world

echo "Docker installation completed."

#--------------------------------------------------------

echo "create a directory for docker data"
sudo mkdir -p /docker/data/

echo "cd to docker data"
sudo cd /docker/data/

# Install Portainer
echo "Creating a volume for Portainer data..."
sudo docker volume create portainer_data

echo "Running Portainer..."
sudo docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce

echo "Portainer installation completed. Access Portainer at http://your-ec2-instance-public-dns:9000"

