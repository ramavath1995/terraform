variable "REGION" {
  default = "us-east-1"
}

variable "AMI" {
  type = map
  default = {
    us-east1 = "ami-04b70fa74e45c3917"
    ap-south-1 = "ami-0f58b397bc5c1f2e8"
  }
}

variable "KEYNAME" {
  default = "vprofile.pem"
}

variable "PRIVATEKEY" {
  default = "vkey"
}

variable "PUBLICKEY" {
  default = "vkey.pub"
}

variable "MYIP" {
  default = "152.58.196.148"
}
variable "RABBITUSER" {
  default = "rabbit"
}

variable "RABBITPASS" {
  default = "rabbit@123456789"
}

variable "ZONE1" {
  default = "us-east-1a"
}

variable "ZONE2" {
  default = "us-east-1b"
}

variable "ZONE3" {
  default = "us-east-1c"
}

variable "BDUSER" {
  default = "admin"
}

variable "BDPASS" {
  default = "admin123"
}

variable "BDNAME" {
  default = "vprofile"
}

variable "CIDER" {
  default = "172.20.0.0/16"
}

variable "VPCNAME" {
  default = "V-VPC"
}

variable "PUBSUB1CIDER" {
  default = "172.20.1.0/24"
}
variable "PUBSUB2CIDER" {
  default = "172.20.2.0/24"
}
variable "PUBSUB3CIDER" {
  default = "172.20.3.0/24"
}

variable "PRVSUB1CIDER" {
  default = "172.20.4.0/24"
}
variable "PRVSUB2CIDER" {
  default = "172.20.5.0/24"
}
variable "PRVSUB3CIDER" {
  default = "172.20.6.0/24"
}