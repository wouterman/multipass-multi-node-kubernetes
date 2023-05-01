multipass launch --name master --memory 2G --cpus 2 --disk 10G 20.04
multipass transfer initialize-master.sh master:.
multipass exec master -- chmod 755 initialize-master.sh
multipass transfer reset-master.sh master:.
multipass exec master -- ./initialize-master.sh

multipass launch --name worker --memory 2G --cpus 2 --disk 10G 20.04
multipass transfer initialize-worker.sh worker:.
multipass exec worker -- chmod 755 initialize-worker.sh
multipass transfer reset-worker.sh worker:.
multipass exec worker -- ./initialize-worker.sh

token=$(multipass exec master -- kubeadm token generate)
kube_join_command=$(multipass exec master -- kubeadm token create $token --print-join-command)
multipass exec worker -- sudo $kube_join_command

#multipass restart master worker
