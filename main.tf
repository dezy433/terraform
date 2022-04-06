provider "aws"{
    region = "eu-west-1"
}


resource "aws_vpc" "devops106_group4_deren_terraform_vpc_tf"{
    cidr_block = "10.201.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true
    tags ={
        Name = "devops106_group4_deren_terraform_vpc"
    }
}


resource "aws_subnet" "devops106_group4_deren_terraform_subnet_app_webserver_tf"{
    vpc_id = local.vpc_id_var
    cidr_block = "10.201.1.0/24"
    tags ={
        Name = "devops106_group4_app_subnet"
    }
}


resource "aws_subnet" "devops106_group4_deren_terraform_subnet_db_webserver_tf"{
    vpc_id = local.vpc_id_var
    cidr_block = "10.201.2.0/24"
    tags ={
    Name = "devops106_group4_deren_db_subnet"
    }
}


resource "aws_internet_gateway" "devops106_group4_deren_terraform_ig_tf"{
    vpc_id = local.vpc_id_var
    tags = {
    Name = "devops106_group4_deren_terraform_ig"
    }
}


resource "aws_route_table" "devops106_group4_deren_terraform_rt_public_tf"{
    vpc_id = local.vpc_id_var

    route{
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.devops106_group4_deren_terraform_ig_tf.id

    }

    tags = {
        Name = "devops106_group4_deren_terraform_rt_public"
    }
}


resource "aws_route_table_association" "devops106_group4_deren_terraform_rt_assoc_app_public_webserver_tf"{
    subnet_id = aws_subnet.devops106_group4_deren_terraform_subnet_app_webserver_tf.id
    route_table_id = aws_route_table.devops106_group4_deren_terraform_rt_public_tf.id
}

resource "aws_route_table_association" "devops106_group4_deren_terraform_rt_assoc_db_public_webserver_tf"{
    subnet_id = aws_subnet.devops106_group4_deren_terraform_subnet_db_webserver_tf.id
    route_table_id = aws_route_table.devops106_group4_deren_terraform_rt_public_tf.id
}


resource "aws_network_acl" "devops106_group4_deren_terraform_nacl_app_public_tf"{
    vpc_id = local.vpc_id_var

    ingress {
        rule_no = 100
        from_port = 22
        to_port = 22
        cidr_block = "0.0.0.0/0"
        protocol = "tcp"
        action = "allow"
    }

    ingress {
        rule_no = 200
        from_port = 27017
        to_port = 27017
        cidr_block = "0.0.0.0/0"
        protocol = "tcp"
        action = "allow"
    }

    ingress {
        rule_no = 10000
        from_port = 1024
        to_port = 65535
        cidr_block = "0.0.0.0/0"
        protocol = "tcp"
        action = "allow"
    }


    egress {
        rule_no = 100
        from_port = 80
        to_port = 80
        cidr_block = "0.0.0.0/0"
        protocol = "tcp"
        action = "allow"
    }

    egress {
        rule_no = 200
        from_port = 443
        to_port = 443
        cidr_block = "0.0.0.0/0"
        protocol = "tcp"
        action = "allow"
    }

    egress {
        rule_no = 10000
        from_port = 1024
        to_port = 65535
        cidr_block = "0.0.0.0/0"
        protocol = "tcp"
        action = "allow"
    }

    subnet_ids = [aws_subnet.devops106_group4_deren_terraform_subnet_app_webserver_tf.id]

    tags={
        Name = "devops106_group4_deren_terraform_nacl_app_public"
    }
}

resource "aws_network_acl" "devops106_group4_deren_terraform_nacl_public_db_tf"{
    vpc_id = local.vpc_id_var

    ingress {
        rule_no = 100
        from_port = 22
        to_port = 22
        cidr_block = "0.0.0.0/0"
        protocol = "tcp"
        action = "allow"
    }

    ingress {
        rule_no = 200
        from_port = 27017
        to_port = 27017
        cidr_block = "0.0.0.0/0"
        protocol = "tcp"
        action = "allow"
    }

    ingress {
        rule_no =10000
        from_port = 1024
        to_port = 65535
        cidr_block = "0.0.0.0/0"
        protocol = "tcp"
        action = "allow"
    }

    egress {
        rule_no =100
        from_port = 80
        to_port = 80
        cidr_block = "0.0.0.0/0"
        protocol = "tcp"
        action = "allow"
    }

    egress{
        rule_no =200
        from_port = 443
        to_port = 443
        cidr_block = "0.0.0.0/0"
        protocol = "tcp"
        action = "allow"
    }

    egress{
        rule_no =10000
        from_port = 1024
        to_port = 65535
        cidr_block = "0.0.0.0/0"
        protocol = "tcp"
        action = "allow"
    }
    subnet_ids = [aws_subnet.devops106_group4_deren_terraform_subnet_db_webserver_tf.id]

    tags={
        Name = "devops106_group4_deren_terraform_nacl_db_public"
    }
}


resource "aws_security_group" "devops106_terraform_group4_deren_sg_app_webserver_tf"{
    name = "devops106_terraform_group4_app_sg"
    vpc_id = local.vpc_id_var

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress{
        from_port = 5000
        to_port = 5000
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress{
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }


  tags ={
    Name = "devops106_group4_deren_terraform_sg_app_webserver"
  }
}


resource "aws_security_group" "devops106_terraform_group4_deren_sg_db_webserver_tf"{
    name = "devops106_terraform_group4_deren__db_sg"
    vpc_id = local.vpc_id_var

    ingress{
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress{
        from_port = 27017
        to_port = 27017
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress{
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags ={
    Name = "devops106_terraform_group4_deren_sg_db_webserver"
    }
}
data "template_file" "app_init" {
  template = file("./init-scripts/docker-install.sh")

}

resource "aws_instance" "devops106_terraform_group4_deren_webserver_app_tf" {
    ami = var.ubuntu_20_04_ami_id_var  #"ami-08ca3fed11864d6bb"
    instance_type = "t2.micro"
    key_name = var.public_key_name_var #can be changed
    vpc_security_group_ids = [aws_security_group.devops106_terraform_group4_deren_sg_app_webserver_tf.id]

    subnet_id = aws_subnet.devops106_group4_deren_terraform_subnet_app_webserver_tf.id
    associate_public_ip_address = true
    count = 2

    user_data = data.template_file.app_init.rendered

    tags ={
        Name ="devops106_terraform_group4_deren_app_webserver_${count.index}"
    }

    connection {
        type = "ssh"
        user = "ubuntu"
        host = self.public_ip
        private_key = file(var.private_key_file_path_var)
    }
/*
    provisioner "file" {
        source      = "/home/vagrant/host/mongo/spartan_terraform-main/database.config"#
        destination = "/home/ubuntu/database.config"
    }

    provisioner "local-exec" {
       command = "echo mongodb://${aws_instance.devops106_terraform_group4_deren_webserver_db_tf.public_ip}:27017 > database.config"
    }


    provisioner "remote-exec" {
        inline = [
            "docker run -d -p 5000:5000 -v /home/ubuntu/database.config:/database.config leiungureanu/spartan_project_vagrant:deren"
        ]#
    }

    provisioner "file" {
      source = "./init-scripts/docker-install.sh"
      destination = "/home/ubuntu/docker-install.sh"

    }
    provisioner "remote-exec" {
        inline = [
            "bash /home/ubuntu/docker-install.sh"
        ]
    }
*/

}

data "template_file" "db_init" {
  template = file("./init-scripts/mongo-install.sh")
}

resource "aws_instance" "devops106_terraform_group4_deren_webserver_db_tf" {
    ami                    =var.ubuntu_20_04_ami_id_var  #"ami-08ca3fed11864d6bb"
    instance_type          = "t2.micro"
    key_name               = var.public_key_name_var
    vpc_security_group_ids = [aws_security_group.devops106_terraform_group4_deren_sg_db_webserver_tf.id]

    subnet_id= aws_subnet.devops106_group4_deren_terraform_subnet_db_webserver_tf.id
    associate_public_ip_address = true
    user_data = data.template_file.db_init.rendered
    tags = {
        Name = "devops106_terraform_group4_deren_db_webserver"
    }

    connection {
        type        = "ssh"
        user        = "ubuntu"
        host        = self.public_ip
        private_key = file(var.private_key_file_path_var)
    }

/*
    provisioner "file" {
      source = "./init-scripts/mongo-install.sh"
      destination = "/home/ubuntu/mongo-install.sh"
    }

    provisioner "remote-exec" {
        inline = [
            "bash /home/ubuntu/mongo-install.sh"
        ]
    }
    */

}

resource "aws_route53_zone" "devops106_dertim_terraform_dns_zone_tf"{
  name="deren.devops106"
  vpc{
    vpc_id = local.vpc_id_var
  }

}

resource "aws_route53_record" "devops106_terraform_deren_dns_db_tf"{
zone_id = aws_route53_zone.devops106_dertim_terraform_dns_zone_tf.zone_id
name = "db"
type = "A"
ttl = "30" #how much time it is going to keep in cache
records = [aws_instance.devops106_terraform_group4_deren_webserver_db_tf.public_ip]
}
