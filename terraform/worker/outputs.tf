output "workerpubip01" {
  value = aws_instance.ec2-kub-worker01.public_ip  
}
output "workerpubip02" {
  value = aws_instance.ec2-kub-worker02.public_ip  
}

