terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}


#AWS Security Group
resource "aws_security_group" "blue_firewall" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  
  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  
  ingress {
    description      = "TLS from VPC"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "blue_firewall"
  }
}

#Run Jenkins Instance
resource "aws_instance" "jenkins_server" {
  ami           = var.ami 
  instance_type = var.instance
  
  tags = {
    Name = "jenkins_server"
  }

  user_data              = <<EOF
    #!/bin/bash
    yum update –y
    wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
    rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
    yum upgrade -y
    amazon-linux-extras install java-openjdk11 -y
    yum install jenkins -y
    systemctl enable jenkins
    systemctl start jenkins
    EOF
}

#S3 Bucket for Jenkins Artifacts
resource "aws_s3_bucket" "bluejenkinsartifactsbucket" {
  bucket = "bluejenkinsartifactsbucket"
}

