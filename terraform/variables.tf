variable "ec2-kub-ami"{
type = string
default = "ami-0c7f9161f8491665f"
description = "AMI for Kubernetes"
}
variable "ec2-kub-vpc"{
type = string
default = "vpc-0ddfec4c1c6b011a0"
description = "VPC for Kubernetes"
}
variable "ec2-kub-region"{
type = string
default = "us-east-2"
description = "VPC for Kubernetes"
}

