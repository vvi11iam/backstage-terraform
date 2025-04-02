terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.10.0"

  backend "remote" {
    # The name of your Terraform Cloud organization.
    organization = "romthayon2310"

    # The name of the Terraform Cloud workspace to store Terraform state files in.
    workspaces {
      name = "backstage-terraform"
    }
  }

}

variable "awsRegion" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "instanceName" {
  description = "EC2 instanceName"
  type        = string
  default     = "none"
}

provider "aws" {
  region = var.awsRegion
}

data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id = "subnet-0b103c2a303579e18"
  security_groups = ["sg-04d1877d7564b9d10"]
  iam_instance_profile                 = "EC2-SSM-Access-Role-EpicReads"
  key_name = "kevin"
  tags = {
    Name = var.instanceName
  }
}
