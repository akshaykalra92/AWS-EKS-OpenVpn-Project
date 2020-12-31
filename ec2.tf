locals {
  private_key_filename = "${var.path}/${var.name}.pem"
}

# Create a new instance of the Ubuntu 18.04 on an

resource "tls_private_key" "vpn" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "vpn" {
  key_name   = "VPN"
  public_key = tls_private_key.vpn.public_key_openssh
}


resource "local_file" "private_key_pem" {
  count    = var.path != "" ? 1 : 0
  content  = tls_private_key.vpn.private_key_pem
  filename = local.private_key_filename
}

resource "null_resource" "chmod" {
  count      = var.path != "" ? 1 : 0
  depends_on = [local_file.private_key_pem]

  triggers = {
    key = tls_private_key.vpn.private_key_pem
  }

  provisioner "local-exec" {
    command = "chmod 600 ${local.private_key_filename}"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_eip" "vpn" {
  instance = module.ec2-instance.id[0]
  vpc      = true
}


resource "null_resource" "wait_10_seconds_ansible" {
  depends_on = [aws_eip.vpn]

  provisioner "local-exec" {
      command = "sleep 10"
    }
}

module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.15.0"
  name = "vpn"
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type_ec2
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  key_name      = aws_key_pair.vpn.key_name
  subnet_ids = module.vpc.public_subnets
}

resource "null_resource" "ansible" {
  connection {
    host = aws_eip.vpn.public_ip
  }

  provisioner "local-exec" {
      command = <<EOT
         sleep 50;
             >openvpn.ini;
            echo "[openVPN]" | tee -a openvpn.ini;
            echo "${aws_eip.vpn.public_ip} ansible_user=${var.ansible_user} ansible_ssh_private_key_file=${local.private_key_filename}" | tee -a openvpn.ini;
      export ANSIBLE_HOST_KEY_CHECKING=False;
           ansible-playbook --user ${var.ansible_user} --private-key ${local.private_key_filename} -i openvpn.ini OpenVPN/playbook.yml
    EOT
}
depends_on = [null_resource.wait_10_seconds_ansible]
}
