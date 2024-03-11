resource "aws_instance" "ec2-kub-master" {
  ami = var.ec2-kub-ami
  instance_type = "t2.micro"
 tags = {
    Name = "master"
  }
  subnet_id = "subnet-009968c59e9d66a3d"
  vpc_security_group_ids = ["sg-0284357dedebf8167"]
  key_name = "ads"
  user_data = <<-EOF
               sudo yum install docker -y
                sudo systemctl enable docker
                sudo systemctl restart docker
               sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
                sudo systemctl enable kubelet
                sudo systemctl start kubelet
                sudo kubeadm init --ignore-preflight-errors=all > /tmp/kubeadm-init.log
                sudo tail -2 /tmp/kubeadm-init.log > /tmp/kubeadmjoin.sh
                sudo mkdir -p $HOME/.kube
                sudo sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
                sudo curl https://raw.githubusercontent.com/projectcalico/calico/v3.27.0/manifests/calico.yaml -O
                sudo kubectl apply -f calico.yaml
    EOF
}

