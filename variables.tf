variable "project_tag" {
  description = "Public subnet ID where bastion will be launched."
}

variable "region" {
  description = "AWS Region e.g. us-west-2"
}
variable "subnet_id" {
  description = "Public subnet ID where bastion will be launched."
}

variable "ssh_key" {
  description = "SSH Key-Pair name for bastion."
}

variable "allowed_hosts" {
  description = "CIDR blocks of networks trusted to connect to bastion."
  type        = list(string)
}

variable "instance_type" {
  description = "Instance type"
  default     = "t2.micro"
}

variable "disk_size" {
  description = "The size of the root volume in gigabytes."
  default     = 10
}

variable "internal_networks" {
  description = "CIDR blocks of internal networks bastion can discover."
  type        = list(string)
}

data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "image-id"
    values = ["ami-0d6621c01e8c2de2c"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  
  filter {
    name   = "owner-id"
    values = ["137112412989"]
  }

}

data "aws_subnet" "public" {
  id = local.subnet_id
}

locals {
  vpc_id        = data.aws_subnet.public.vpc_id
  project       = var.project_tag
  ami_id        = data.aws_ami.amazon_linux.id
  disk_size     = var.disk_size
  subnet_id     = var.subnet_id
  ssh_key       = var.ssh_key
  instance_type = var.instance_type
  region        = var.region
}

