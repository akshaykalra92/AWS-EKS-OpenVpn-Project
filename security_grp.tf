resource "aws_security_group" "allow_tls" {
  name        = "VPN_security_grp"
  description = "Allow TLS"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "VPN port"
    from_port   = 1194
    to_port     = 1194
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ssh"
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
    Name = "allow_tls"
    iac_environment = var.iac_environment_tag
  }
}
