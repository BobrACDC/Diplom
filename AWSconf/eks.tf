module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "netology-cluster"
  cluster_version = "1.20"
  subnets         = module.vpc.private_subnets

  vpc_id = module.vpc.vpc_id


  worker_groups = [
    {
      asg_max_size  = 3
      ami = "ami-0c7ea5497c02abcaf"
      instance_type = "t2.medium"
      vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]
      # subnet_id = "${aws_subnet.public.id}"
      monitoring = true
      subnet_id   = aws_subnet.public.id
      associate_public_ip_address = true
      key_name= "kuber"
    }
  ]
}
