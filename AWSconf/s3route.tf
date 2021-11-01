resource "aws_vpc_endpoint" "s3" {
  vpc_id       = module.vpc.vpc_id
  service_name = "com.amazonaws.us-west-2.s3"
  vpc_endpoint_type = "Gateway"
}

resource "aws_vpc_endpoint_route_table_association" "as_s3" {
  route_table_id  = aws_route_table.pub_to_inet.id
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
}

resource "aws_route53_zone" "dns" {
  name = "diplomach.com"
  vpc {
    vpc_id = module.vpc.vpc_id
  }
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.dns.zone_id
  name    = "www.diplomach.com"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_elb.my_elb.dns_name]
}

resource "aws_elb" "my_elb" {
  name  = "my-elb"
  subnets = [aws_subnet.private.id]
  internal = true


  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 10
    timeout             = 5
    target              = "HTTP:80/index.html"
    interval            = 15
  }

  security_groups = [aws_security_group.allow_all.id]

  cross_zone_load_balancing   = true
  idle_timeout                = 120
  connection_draining         = true
  connection_draining_timeout = 300

  tags = {
    Name = "my_elb"
  }
}

