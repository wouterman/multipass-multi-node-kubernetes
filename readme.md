# Instructions
This repository contains scripts to setup a multinode kubernetes cluster on Windows using Multipass based off the instructions in [this](https://github.com/stazdx/k8s-local-environment) repository.
However, the instructions in that repository are quite old and not entirely correct anymore. Where aplicable, I've updated them in the scripts.

The scripts use [Multipass](https://multipass.run/install) to setup two VMs (master and worker), install K8s and join them as nodes together.

Use `startup.bat` to set everything up and `cleanup.bat` to remove them.
If you need to reset the node for whatever reason without deleting the vm use the reset-XXX.sh scripts inside the VM. 
(This usually happens when you restart your computer as Multipass VMs don't seem to have static IPs).