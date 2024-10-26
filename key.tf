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