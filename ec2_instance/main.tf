terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 3.0"
    }
  }
}
provider "aws" {
    region = var.region
  
}
module "ec2_instance" {
  source        = "github.com/Sudha2804/Terraform-module/ec2_instance"
  region        = var.region
  instance_type = var.instance_type
}
