resource "aws_ec2_client_vpn_network_association" "vpn_priv_sub" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.vpn.id
  subnet_id              = aws_subnet.public.id
  security_groups = [aws_security_group.allow_all.id]
}


resource "aws_ec2_client_vpn_endpoint" "vpn" {
  description            = "vpn-test"
  server_certificate_arn = "arn:aws:acm:us-west-2:852685279756:certificate/8963c3de-8960-4644-a593-27b636e28e56"
  split_tunnel = true
  client_cidr_block      = "10.0.0.0/22"
  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = "arn:aws:acm:us-west-2:852685279756:certificate/67b11e75-dfae-4614-b173-546464f0d9d1"
  }
  connection_log_options {
    enabled               = false
  }
}

resource "aws_ec2_client_vpn_authorization_rule" "vpn_auth_rule" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.vpn.id
  target_network_cidr    = aws_subnet.private.cidr_block
  authorize_all_groups   = true
}


