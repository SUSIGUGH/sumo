#!/bin/bash
option="$1"
if [ "$option" == "-o" ];
then
sudo yum remove docker -y
sudo yum install docker -y
sudo hostnamectl set-hostname master01
sudo systemctl enable docker
sudo systemctl restart docker
sudo cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.28/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v1.28/rpm/repodata/repomd.xml.key
exclude=kubelet kubeadm kubectl
EOF
sudo yum remove -y kubelet kubeadm kubectl
rm -f $HOME/.kube/config
sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
sudo systemctl enable kubelet
sudo systemctl start kubelet
sudo kubeadm init --ignore-preflight-errors=all > /tmp/kubeadm-init.log
sudo tail -2 /tmp/kubeadm-init.log > /tmp/kubeadmjoin.sh
sudo mkdir -p $HOME/.kube
sudo sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo sudo chown $(id -u):$(id -g) $HOME/.kube/config
sudo curl https://raw.githubusercontent.com/projectcalico/calico/v3.27.0/manifests/calico.yaml -O
sudo kubectl apply -f calico.yaml
else
	which docker
	if [ $? -eq 0 ];
	then
		echo "Docker Already Installed"
	else
		sudo yum install docker -y
		sudo systemctl enable docker
		sudo systemctl restart docker
	fi
	which kubeadm
	if [ $? -eq 0 ];
        then
                echo "Kubenetes Already Installed"
        else
		rm -f $HOME/.kube/config
		sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
		sudo systemctl enable kubelet
		sudo systemctl start kubelet
		sudo kubeadm init --ignore-preflight-errors=all > /tmp/kubeadm-init.log
		sudo tail -2 /tmp/kubeadm-init.log > /tmp/kubeadmjoin.sh
		sudo mkdir -p $HOME/.kube
		sudo sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
		sudo curl https://raw.githubusercontent.com/projectcalico/calico/v3.27.0/manifests/calico.yaml -O
		sudo kubectl apply -f calico.yaml
        fi

fi
