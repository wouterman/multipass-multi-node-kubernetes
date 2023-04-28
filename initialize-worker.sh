#!/bin/bash

SUDO=''
if (( $EUID != 0 )); then
    SUDO='sudo'
fi

$SUDO sh -c 'apt-get update \
&& apt-get upgrade -y \
&& apt-get install -y apt-transport-https ca-certificates curl \
&& curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg \
&& echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" |  tee /etc/apt/sources.list.d/kubernetes.list \
&& apt-get update \
&& apt-get install -y kubeadm=1.26.0-00 kubelet=1.26.0-00 \
&& apt-mark hold kubelet kubeadm \
&& apt-get install containerd -y \
&& mkdir -p /etc/containerd \
&& containerd config default >> /etc/containerd/config.toml \
&& apt-get clean -y \
&& apt-get autoclean -y \
&& apt-get autoremove -y \
&& echo 'net.bridge.bridge-nf-call-iptables = 1' >> /etc/sysctl.conf'

$SUDO sh -c 'sysctl --system \
&& modprobe overlay \
&& modprobe br_netfilter \
&& hostnamectl set-hostname worker \
&& swapoff -a \
&& echo '1' > /proc/sys/net/ipv4/ip_forward'
