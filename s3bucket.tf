terraform {
  backend "s3" {
    bucket = "terra-state29"
    key = "terraform/backend"
    region = "us-east-1"
  }
}