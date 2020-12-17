
resource "aws_instance" "dev_tes_cm1" { //creating intance cm1
  instance_type = var.instance_types["cm1"]
  

  key_name               = "AD"
  subnet_id              = aws_subnet.dev_subnet_private_1a.id
  vpc_security_group_ids = ["${aws_security_group.my_sg.id}"]
  ami                    = lookup(var.ami, var.region)
  tags = {
    name = "dev-tes-cm1"
  }
  root_block_device {
    volume_size           = 10
    volume_type           = "gp2"
    encrypted             = true
    delete_on_termination = true
  }
  /*provisioner "local-exec" {
    command = "echo ${aws_instance.dev_tes_cm1.public_ip} > ip_address.txt"
  }*/

}
resource "aws_instance" "dev_tes_cm2" { //creating intance cm2
  instance_type          = var.instance_types["cm2"]
 
  key_name               = "AD"
  subnet_id              = aws_subnet.dev_subnet_private_1a.id
  vpc_security_group_ids = ["${aws_security_group.my_sg.id}"]
  ami                    = lookup(var.ami, var.region)
  tags = {
    name = "dev-tes-cm2"
  }
  root_block_device {
    volume_size           = 10
    volume_type           = "gp2"
    encrypted             = true
    delete_on_termination = true
  }
}
resource "aws_instance" "dev_tes_primary" { //creating intance primary
  instance_type          = var.instance_types["primary"]

  ami                    = lookup(var.ami, var.region)
  subnet_id              = aws_subnet.dev_subnet_private_1a.id
  vpc_security_group_ids = ["${aws_security_group.my_sg.id}"]
  key_name               = "AD"
  /*provisioner "remote-exec" {
    inline = ["sudo apt-get update", "sudo apt-get install apache2 -y", ]
    connection {
      host        = aws_instance.dev_tes_primary.private_ip
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("C:/Users/farhan/Desktop/aws-keys/AD.pem")
      timeout     = "1m"
      agent       = false
    }
  }*/


  tags = {
    name = "dev-tes-primary"
  }
  root_block_device {
    volume_size           = 10
    volume_type           = "gp2"
    encrypted             = true
    delete_on_termination = true
  }
}
resource "aws_instance" "jump_host" { //creating intance cm2
  instance_type               = var.instance_types["jump"]
  
  subnet_id                   = aws_subnet.dev_subnet_public_1a.id
  vpc_security_group_ids      = ["${aws_security_group.my_sg.id}"]
  key_name                    = "AD"
  associate_public_ip_address = true

  ami = lookup(var.ami, var.region)
  tags = {
    name = "jump_host"
  }
  root_block_device {
    volume_size           = 10
    volume_type           = "gp2"
    encrypted             = true
    delete_on_termination = true
  }
}
  /*provisioner "remote-exec" {
    inline = ["echo 'some date' ? somedata.txt", ]
    connection {
      host        = aws_instance.jump_host.public_ip
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("C:/Users/farhan/Desktop/aws-keys/AD.pem")
      timeout     = "1m"
      agent       = true
    }
  }
}

resource "aws_eip" "ip" {
  instance = lookup(var.ami, var.region)
  vpc      = true
}
*/
