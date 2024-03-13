resource "aws_instance" "ec2-kub-worker01" {
  ami = var.ec2-kub-ami
  instance_type = "t2.micro"
 tags = {
    Name = "worker01"
  }
  subnet_id = "subnet-009968c59e9d66a3d"
  vpc_security_group_ids = ["sg-0284357dedebf8167"]
  key_name = "ads"
  user_data = <<-EOF
     #!/bin/bash
     yum install docker -y
     systemctl enable docker
     systemctl restart docker
     cat <<EOF1 > /etc/yum.repos.d/kubernetes.repo
     [kubernetes]
     name=Kubernetes
     baseurl=https://pkgs.k8s.io/core:/stable:/v1.28/rpm/
     enabled=1
     gpgcheck=1
     gpgkey=https://pkgs.k8s.io/core:/stable:/v1.28/rpm/repodata/repomd.xml.key
     exclude=kubelet kubeadm kubectl
     EOF1
     yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
     systemctl enable kubelet
     systemctl start kubelet
     EOF
}

resource "aws_instance" "ec2-kub-worker02" {
  ami = var.ec2-kub-ami
  instance_type = "t2.micro"
 tags = {
    Name = "worker02"
  }
  subnet_id = "subnet-009968c59e9d66a3d"
  vpc_security_group_ids = ["sg-0284357dedebf8167"]
  key_name = "ads"
  user_data = <<-EOF
     #!/bin/bash
     yum install docker -y
     systemctl enable docker
     systemctl restart docker
     cat <<EOF1 > /etc/yum.repos.d/kubernetes.repo
     [kubernetes]
     name=Kubernetes
     baseurl=https://pkgs.k8s.io/core:/stable:/v1.28/rpm/
     enabled=1
     gpgcheck=1
     gpgkey=https://pkgs.k8s.io/core:/stable:/v1.28/rpm/repodata/repomd.xml.key
     exclude=kubelet kubeadm kubectl
     EOF1
     yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
     systemctl enable kubelet
     systemctl start kubelet
     EOF
}
