resource "aws_security_group" "SG_PublicSubnet1" {
  name        = var.sg_name
  description = "Allow HTTP"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP from VPC"
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output sg_id {
  value       = aws_security_group.SG_PublicSubnet1.id

}
