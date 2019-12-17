provider "vault" {
  # This will default to using $VAULT_ADDR
  # But can be set explicitly
  # address = "https://vault.example.net:8200"
  # export VAULT_ADDR
  # export VAULT_URL
  auth_login {
    # You can use any auth method, this is just an example. Complete reference: https://www.terraform.io/docs/providers/vault/index.html
    path = "auth/userpass/login/${var.login_username}"

    parameters = {
      password = var.login_password
    }
  }
}

# The vault_generic_secret endpoint is very flexible, a few examples:
data "vault_generic_secret" "my_static_secret" {
  path = "secret/foo"
}

data "vault_generic_secret" "my_static_secret2" {
  path = var.static_secret_endpoint
}

data "vault_generic_secret" "my_dynamic_secret" {
  path = "database/creds/${var.dynamic_secret_role}"
}

data "vault_generic_secret" "my_dynamic_secret2" {
  path = var.dynamic_secret_endpoint
}

# The secrets can be used anywhere. In this example, we will put them in a template to be deployed with server
data "template_file" "init" {
  template = "${file("vault_bootstrap_demo.sh.tpl")}"
  vars = {
    static_secret1 = data.vault_generic_secret.my_static_secret
    static_secret2 = data.vault_generic_secret.my_static_secret2
    dynamic_secret1 = data.vault_generic_secret.my_dynamic_secret
    dynamic_secret2 = data.vault_generic_secret.my_dynamic_secret2
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "ubuntu" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.aws_instance_type
  availability_zone = var.aws_az

  key_name    = var.aws_key
  user_data = data.template_file.init.rendered
  vpc_security_group_ids = ["${aws_security_group.ec2_sg.id}"]
  tags = {
    Owner = "Stenio Ferreira"
    TTL = "24"
  }
}

resource "aws_security_group" "ec2_sg_vault_client" {
  name        = "ec2_sg_vault_client"
  description = "SG for Vault Poc - Stenio Ferreira"
  ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}