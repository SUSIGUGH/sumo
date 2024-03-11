terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Define the provider
provider "aws" {
  region = var.ec2-kub-region
}
module "ec2-kub-master"{
source = "./master"
}


