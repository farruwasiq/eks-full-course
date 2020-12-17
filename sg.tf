resource "aws_security_group" "my_sg" {
  vpc_id = local.vpc_id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_source] //to allow ssh from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.allowed_source]
  }
  tags = {
    name        = "ssh-allowed"
    environment = "dev"
  }
}
resource "aws_security_group" "lb_sg" {
  vpc_id = local.vpc_id


  name        = "lb_sg"
  description = "out elb security group"


  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.allowed_source]

  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}