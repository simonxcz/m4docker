# provider : fournisseur
provider "aws" {   
  access_key = "${var.access_key}"    #"AKIA4WFWEKKIYFGZMW5U"
  secret_key = "${var.secret_key}"    #"b2E2FQCCPzcInKo2bb6H4BXNGEalmTeX3huRupVC"
  region = "${var.region}"
}

# resource : machine virtuelle
resource "aws_instance" "example_amazon_linux_2_xc" {
    ami = "ami-02ccb28830b645a41"
    instance_type = "t2.micro"
    key_name   = "key_xc"
    security_groups = ["ssh", "default"]  # commentaire
    depends_on = ["aws_s3_bucket.example_amazon_linux_2_xc"]

    provisioner "local-exec" { #provisioner execute only en création de l'instance
      command = "echo ${aws_instance.example_amazon_linux_2_xc.public_ip} > ip_adress.txt"
    }
}

resource "aws_s3_bucket" "example_amazon_linux_2_xc" {
  bucket = "terraform-getting-started-guide-xc"
  acl = "private"
}

