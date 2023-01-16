

resource "aws_instance" "worker" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  subnet_id              = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.boundary.id]
#   user_data              = templatefile("./scripts/consul-server-init.sh", {
#     consul_datacenter = var.consul_datacenter
#     consul_acl_token  = random_uuid.bootstrap_token.result
#     consul_gossip_key = random_id.gossip_encryption_key.b64_std
#     consul_ca_cert    = tls_self_signed_cert.ca.cert_pem
#     consul_ca_key     = tls_private_key.ca.private_key_pem
#     consul_version    = var.consul_version
#   })
  key_name = aws_key_pair.boundary_demo_worker.key_name
  tags = {
    Name = "${var.name}-iap-worker"
    Env  = "boundary"
  }
}

resource "aws_key_pair" "boundary_demo_worker" {
  public_key = file("~/.ssh/hcp-demo.pub")
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}