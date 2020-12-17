output "vpc_id" {
  value       = local.vpc_id
  description = "this is our vpc id"
}
output "public_subnet_1a" {

  value       = aws_subnet.dev_subnet_public_1a.id
  description = "this is public subnet id"
}
output "private_subnet_1a" {
  value = aws_subnet.dev_subnet_private_1a.id
}
output "public-subnet-1b" {
  value = aws_subnet.dev_subnet_public_1b.id
}
output "private_subnet_1b" {
  value = aws_subnet.dev_subnet_private_1b.id

}
/*
output "load_balancer" {
  value = aws_lb.tes_lb_dev.id
}
*/


/*iam specific policy permission
-put perm
-get perm
volume creation for every ec2 instance
load balancer create
autoscaling ec2
sg associatin to ec2
ami image creation-auto scaling
kms key-data encryption
pem key creation
jump host create in public subnet
*/
