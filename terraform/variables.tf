variable "ec2-kub-ami"{
type = string
default = "ami-0187337106779cdf8"
description = "AMI for Kubernetes"
}
variable "ec2-kub-vpc"{
type = string
default = "vpc-00c9962d6840d8c99"
description = "VPC for Kubernetes"
}
variable "ec2-kub-region"{
type = string
default = "ap-south-1"
description = "VPC for Kubernetes"
}
variable "key_name"{
type = string
default = ""
}
