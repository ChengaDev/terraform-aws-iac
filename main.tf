terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.24.0"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  region      = "us-west-2"
}

resource "aws_ami" "spec_ami" {
  name                = "terraform-example"
  virtualization_type = "hvm"
  root_device_name    = "/dev/xvda2"

  ebs_block_device {
    device_name = "/dev/xvda2"
    snapshot_id = "snap-xxxxxxxx"
    volume_size = 8
    ### TFAWS007P ###
    encrypted = true
  }
}

resource "aws_api_gateway_rest_api" "spec_api_gateway" {
  name = "regional-example"

  ### TFAWS016P ###
  endpoint_configuration {
    types = ["PRIVATE"]
  }
}

# resource "aws_db_instance" "spec_db" {
#   allocated_storage    = 20
#   storage_type         = "gp2"
#   engine               = "mysql"
#   engine_version       = "5.7"
#   instance_class       = "db.t2.micro"
#   name                 = "mydb"
#   username             = "foo"
#   password             = "foobarbaz"
#   iam_database_authentication_enabled = true
#   storage_encrypted = true
#   ca_cert_identifier = "rds-ca-2019"
#   auto_minor_version_upgrade = true
# }

resource "aws_s3_bucket" "spec_bucket" {
    bucket = "my-tf-test-bucket"
    acl    = "private"
    
    tags = {
        Name        = "My bucket"
        Environment = "Dev"
    }
    
  ## TFAWS274P ###
  # server_side_encryption_configuration {
  #   rule {
  #     apply_server_side_encryption_by_default {
  #       sse_algorithm = "AES256"
  #     }
  #   }
  # }
    
  ## TFAWS270P ###
  # versioning {
  #   mfa_delete = true
  # }
}