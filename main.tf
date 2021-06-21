data "aws_ami" "ubuntu" {

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20200924"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "template_file" "install" {
  template = file("${path.module}/install.sh")
  vars = {
    instanceName = var.instanceName
  }
}

data "template_cloudinit_config" "cloudInit" {
  gzip          = true
  base64_encode = true

  part {
    filename     = "install.sh"
    content_type = "text/x-shellscript"
    content      = data.template_file.install.rendered
  }
}

resource "aws_security_group" "securityGroup" {
  name        = var.instanceName
  description = "Allow traffic"

  ingress {
    description = "SSH Default Port"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.instanceName
  }
}

resource "aws_instance" "instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instanceType

  root_block_device {
    volume_size = var.diskSize
    volume_type = var.diskType
    encrypted = var.diskEncrypted
    delete_on_termination = var.diskTermination
  }

  security_groups = [aws_security_group.securityGroup.name]

  user_data_base64 = data.template_cloudinit_config.cloudInit.rendered

  tags = {
    Name = var.instanceName
  }
}