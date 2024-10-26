1. Create s3 and store the tf-state file for maintaining the state of your infrastructure
Write a backend.tf file 
    terraform {
        backend "s3" {
            bucket = "terra-state29"
            key = "terraform/backend"
            region = "us-east-1"
        }
    }

2. Generate the key key.tf
    resource "tls_private_key" "vkey" {
        algorithm = "RSA"
        rsa_bits = "4096"
    }

    resource "aws_key_pair" "v-key-pair" {
        public_key = tls_private_key.vkey.public_key_openssh
        key_name = var.KEYNAME
    }

    resource "local_file" "local-key" {
        content = tls_private_key.vkey.private_key_pem
        filename = var.KEYNAME
    }
3. Create vpc using vpc module 
    module "vpc" {
        source = "terraform-aws-modules/vpc/aws"
        name = var.VPCNAME
        cidr = var.CIDER
        azs = [var.ZONE1,var.ZONE2, var.ZONE3]
        private_subnets = [PRVSUB1CIDER, PRVSUB2CIDER, PRVSUB3CIDER]
        public_subnets = [PUBSUB1CIDER, PUBSUB2CIDER, PUBSUB3CIDER]

        enable_nat_gateway = "true"
        single_nat_gateway = "true"
        enable_dns_support = "true"
        enable_dns_hostnames = "true"

        tags={
            name = "vprofile-vpc"
        }
    }

