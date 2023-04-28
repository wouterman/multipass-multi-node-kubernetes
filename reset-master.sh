#!/bin/bash

SUDO=''
if (( $EUID != 0 )); then
    SUDO='sudo'
fi

$SUDO sh -c 'sysctl --system \
&& modprobe overlay \
&& modprobe br_netfilter \
&& hostnamectl set-hostname master \
&& swapoff -a \
&& echo '1' > /proc/sys/net/ipv4/ip_forward \
&& echo "y" | kubeadm reset \
&& rm -rf $HOME/.kube \
&& kubeadm init \
&& mkdir -p $HOME/.kube \
&& cp -i /etc/kubernetes/admin.conf $HOME/.kube/config \
&& chown $(id -u):$(id -g) $HOME/.kube/config \
&& kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"'