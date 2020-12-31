output "public_key_openssh" {
  value = tls_private_key.vpn.public_key_openssh
}

output "private_key_pem" {
  value = tls_private_key.vpn.private_key_pem
}
