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