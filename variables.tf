variable "project_tag" {
  description = "EC2 Tag to identify the project where bastion will be used. "
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
  description = "Instance type for bastion server"
  default     = "t2.micro"
}

variable "disk_size" {
  description = "Root volume size in GB for bastion server."
  default     = 10
}

variable "internal_networks" {
  description = "CIDR blocks of internal networks bastion can discover."
  type        = list(string)
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.20200406.0-x86_64-gp2"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
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

