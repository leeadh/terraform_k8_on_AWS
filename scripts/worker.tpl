#!/bin/bash

#installing kubeadm
sudo apt-get update && sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

echo 'Finished installing kubeadm' > /home/ubuntu/kubeadm.log

#installing docker
sudo apt-get install docker.io -y
sudo usermod -a -G docker $USER
cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

mkdir -p /etc/systemd/system/docker.service.d

# Restart docker.
systemctl daemon-reload
systemctl restart docker

echo 'Finished installing kubeadm' > /home/ubuntu/docker.log

#setting permission
sudo bash -c 'echo 1 > /proc/sys/net/ipv4/ip_forward'
sudo bash -c 'echo 1 > /proc/sys/net/bridge/bridge-nf-call-iptables'

kubeadm join --discovery-token-unsafe-skip-ca-verification --token=y7yaev.9dvwxx6ny4ef8vlq ${masterIP}:6443
