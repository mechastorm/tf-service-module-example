resource "aws_security_group" "server" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks     = ["${data.aws_vpc.selected.cidr_block}"]
  }
}

data "aws_vpc" "selected" {
  id = "${var.vpc_id}"
}


