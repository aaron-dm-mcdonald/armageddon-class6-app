# Find and replace or add the variables for var.name, var.vpc_id, var.public_subnet_ids, var.db_user, var.db_password
# add provider alias if you arent using modules



data "aws_ami" "this" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-kernel-6.1-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "ena-support"
    values = ["true"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}


# Security Group for Bastion Host
resource "aws_security_group" "this" {
  name        = "${var.name}-bastion"
  description = "Allow SSH and ICMP access to the bastion host"
  vpc_id      = var.vpc_id

  # Allow SSH access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Restrict to your IP for production
  }

  # Allow ICMP traffic (e.g., ping)
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"] # Restrict to your IP or network
  }

  # Allow all egress traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-bastion-sg"
  }
}




# EC2 Instance
resource "aws_instance" "bastion_host" {
  ami           = data.aws_ami.this.id # Amazon Linux 2 AMI (replace with the region-specific AMI ID)
  instance_type = "t2.micro"
  subnet_id     = var.public_subnet_ids
  vpc_security_group_ids = [
    aws_security_group.this.id
  ]

  tags = {
    Name = "${var.name}-bastion-host"
  }

  # Use templatefile to dynamically generate the user_data script
  user_data = templatefile(
    "./scripts/app/bastion-host.sh.tpl",
    {
      db_host     = module.osaka_database.rw_endpoint,
      db_user     = var.db_user,        # Pass from variables
      db_password = var.db_password,  
      db_name     = "user_db"      
    }
  )
}