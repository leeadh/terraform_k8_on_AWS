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

echo 'Finished installing kubeadm' > /home/ubuntu/docker.log

#setting permission
sudo bash -c 'echo 1 > /proc/sys/net/ipv4/ip_forward'
sudo bash -c 'echo 1 > /proc/sys/net/bridge/bridge-nf-call-iptables'

sudo kubeadm init --token=y7yaev.9dvwxx6ny4ef8vlq
sudo mkdir -p /home/ubuntu/.kube
sudo cp /etc/kubernetes/admin.conf /home/ubuntu/.kube/config
sudo chown $(id -u):$(id -g) /home/ubuntu/.kube/config
sudo chmod 777 /home/ubuntu/.kube/config

echo '[Finished] created kubernetes cluster.Preparing to install components' > /home/ubuntu/master.log


cd /home/ubuntu/
git clone https://github.com/leeadh/node-jenkins-app-example.git
kubectl create configmap mongo-initdb --from-file=node-jenkins-app-example/Kubernetes/init_data.js
if [ -f /home/ubuntu/.kube/config ]; then
    echo "Installing calico..."
    kubectl apply -f ./node-jenkins-app-example/Kubernetes/calico.yaml
    echo '[Finished] installing calico' | sudo tee -a /home/ubuntu/master.log
fi
kubectl apply -f ./node-jenkins-app-example/Kubernetes/mongodb.yaml
echo '[Finished] installing mongodb' | sudo tee -a /home/ubuntu/master.log
kubectl apply -f ./node-jenkins-app-example/Kubernetes/sample.yaml
echo '[Finished] kubernetes cluster created successful' > /home/ubuntu/master.log

