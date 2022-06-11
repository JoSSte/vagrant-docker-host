#!/bin/bash

sudo sed -i 's/AcceptEnv/\#AcceptEnv/g' /etc/ssh/sshd_config
sudo /etc/init.d/ssh reload

### INSTALL APT PACKAGES ###
export DEBIAN_FRONTEND=noninteractive

sudo apt-get update
sudo apt-get upgrade -y

# Install docker stuff https://docs.docker.com/engine/install/ubuntu/
sudo apt-get install -y ca-certificates curl gnupg lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
     $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Allow vagrant user to run docker https://docs.docker.com/engine/install/linux-postinstall/
sudo groupadd docker
sudo usermod -aG docker $USER

# initiate docker service on boot
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

# Make docker service listen on TCP port 4243
sudo sed -i "s/ExecStart.*$/ExecStart=\/usr\/bin\/dockerd -H tcp:\/\/0.0.0.0:4243 -H unix:\/\/\/var\/run\/docker.sock/" /lib/systemd/system/docker.service
## This is an alternative to the above method
#sudo echo -e "{\n  \"hosts\": [\"unix:///var/run/docker.sock\", \"tcp://127.0.0.1:4243\"]\n}" > /tmp/daemon.json
#sudo mv /tmp/daemon.json /etc/docker/daemon.json

# Restart docker service
sudo systemctl daemon-reload
sudo service docker restart

sudo apt-get upgrade -y

LOCAL_IP_LIST=`ip addr show | grep -Po 'inet \K[\d.]+'` 
# Allow remote connections to mysql (don't do it like this in production)

