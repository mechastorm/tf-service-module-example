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

resource "aws_instance" "server" {
  ami = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"

  ebs_optimized = true

  subnet_id = "${var.subnet_id}"
  vpc_security_group_ids = [
    "${aws_security_group.server.id}"
  ]

  tags {
    Name = "HelloWorld"
  }
}