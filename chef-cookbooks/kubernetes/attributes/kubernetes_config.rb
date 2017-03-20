default['config']['KUBE_MASTER'] = 'KUBE_MASTER="--master=http://master:8080"'
default['config']['KUBE_ETCD_SERVERS'] = 'KUBE_ETCD_SERVERS="--etcd-seervers=http://master:2379"'

default['apiserver']['KUBE_API_ADDRESS'] = 'KUBE_API_ADDRESS="--address=0.0.0.0"'
default['apiserver']['KUBE_API_PORT'] = 'KUBE_API_PORT="--port=8080"'
default['apiserver']['KUBELET_PORT'] = 'KUBELET_PORT="--kubelet-port=10250"'
default['apiserver']['KUBE_ETCD_SERVERS'] = 'KUBE_ETCD_SERVERS="--etcd-servers=http://master:2379"'
default['apiserver']['KUBE_ADMISSION_CONTROL'] = '# KUBE_ADMISSION_CONTROL'

default['kubelet']['KUBELET_ADDRESS'] = 'KUBELET_ADDRESS="--address=0.0.0.0"'
default['kubelet']['KUBELET_PORT'] = 'KUBELET_PORT="--port=10250"'
default['kubelet']['KUBELET_HOSTNAME'] = "KUBELET_HOSTNAME=\"--hostname-override=#{Chef::Config[:node_name]}\""
default['kubelet']['KUBELET_API_SERVER'] = 'KUBELET_API_SERVER="--api-servers=http://master:8080"'
default['kubelet']['KUBELET_POD_INFRA_CONTAINER'] = '# KUBELET_POD_INFRA_CONTAINER'
