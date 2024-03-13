output "masterpubip" {
  value = module.ec2-kub-master 
}
output "workerpubips" {
  value = module.ec2-kub-worker 
}
