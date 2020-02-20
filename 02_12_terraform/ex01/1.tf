provider "aws" {   # provider 虚拟机服务提供商
  access_key = "${var.access_key}"    #"AKIA4WFWEKKIYFGZMW5U"
  secret_key = "${var.secret_key}"    #"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"
  region = "${var.region}"
}

# resource : machine virtuelle
resource "aws_instance" "ex_vm1_xc" {
    ami = "ami-02ccb28830b645a41"     # image modèle name
    instance_type = "t2.micro"        # la taille de VM
    key_name   = "key_xc"             # clé RSA ssh
    security_groups = ["ssh", "default"]  # AWS security groups

    provisioner "local-exec" { # provisioner execute only en création de l'instance
      command = "echo ${aws_instance.ex_vm1_xc.public_ip} > ip_adress.txt"
    }
}

resource "aws_instance" "ex_vm2_xc" {
    ami = "ami-02ccb28830b645a41"
    instance_type = "t2.micro"
    key_name   = "key_xc"
    security_groups = ["ssh", "default", "ex_xc_8080"]  # 
    depends_on = ["aws_security_group.ex_xc_8080"]    

    provisioner "local-exec" { # provisioner execute only en création de l'instance
      command = "echo ${aws_instance.ex_vm2_xc.public_ip} > ip_adress.txt"
    }
}

###########
resource "aws_security_group" "ex_xc_8080" {
  name        = "ex_xc_8080"
  description = "Allow connexion 8080"
  # vpc_id      = "${aws_vpc.main.id}"

  ingress {
    # TLS (change to whatever ports you need)
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["0.0.0.0/0"] # allows which ip to get access VM
  }

  egress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    # prefix_list_ids = ["pl-12c4e678"]
  }
}