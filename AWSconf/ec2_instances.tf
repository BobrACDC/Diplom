data "aws_ami" "debian" {
  most_recent = true

  filter {
    name   = "name"
    values = ["debian-10-amd64-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["136693071363"] # Canonical
}
resource "aws_instance" "kuber" {
  count = var.instance_count
  ami = "ami-0c7ea5497c02abcaf"
  instance_type = "t2.medium"
  vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]
  # subnet_id = "${aws_subnet.public.id}"
  monitoring = true
  subnet_id   = aws_subnet.public.id
  associate_public_ip_address = true
  key_name= "kuber"

  connection {
    private_key = file("/home/bobr/Documents/Education/Netology/DevOps/Diploma/creds/kuber.pem")
   }
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "kuber"
  }
}

resource "aws_launch_configuration" "kuber" {
  image_id                    = data.aws_ami.debian.id
  instance_type               = "t2.medium"
  security_groups             = [aws_security_group.allow_all.id]
  key_name                    = "kuber"

}

