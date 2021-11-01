resource "aws_security_group" "allow_all" {
  vpc_id = module.vpc.vpc_id
  name        = "allow_all"
  description = "Allow all inbound traffic"
}

resource "aws_security_group_rule" "ingress_ipv4" {
  type        = "ingress"
  from_port   = 0
  to_port     = 0
  protocol    = -1
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.allow_all.id}"
}
resource "aws_security_group_rule" "egress_ipv4" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = -1
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.allow_all.id}"
}
