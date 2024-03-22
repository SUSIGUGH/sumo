output "masterpubip" {
  value = aws_instance.ec2-kub-master.public_ip  
}
output "private_key" {
  value     = tls_private_key.pemkey.private_key_pem
  sensitive = true
}

