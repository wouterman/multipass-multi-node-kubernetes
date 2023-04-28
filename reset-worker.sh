#!/bin/bash

SUDO=''
if (( $EUID != 0 )); then
    SUDO='sudo'
fi

$SUDO sh -c 'sysctl --system \
&& modprobe overlay \
&& modprobe br_netfilter \
&& hostnamectl set-hostname worker \
&& swapoff -a \
&& echo '1' > /proc/sys/net/ipv4/ip_forward \
&& kubeadm reset \
&& rm -rf $HOME/.kube'