CALL cleanup.bat

multipass launch --name master --memory 2G --cpus 2 --disk 10G 20.04
multipass transfer initialize-master.sh master:.
multipass transfer reset-master.sh master:.
multipass exec master -- ./initialize-master.sh

multipass launch --name worker --memory 2G --cpus 2 --disk 10G 20.04
multipass transfer initialize-worker.sh worker:.
multipass transfer reset-worker.sh worker:.
multipass exec worker -- ./initialize-worker.sh


FOR /F "tokens=* USEBACKQ" %%F IN (`multipass exec master -- sudo sh -c "token=$(kubeadm token generate) && kubeadm token create $token --print-join-command"`) DO (
SET kube_join_command=%%F
)

multipass exec worker -- sudo %kube_join_command%

multipass shell master