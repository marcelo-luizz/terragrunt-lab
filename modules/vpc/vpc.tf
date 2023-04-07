module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name   = var.vpc_name
  cidr   = var.cidr

  azs                  = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets       = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  database_subnets     = ["10.0.201.0/24", "10.0.202.0/24", "10.0.203.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}

output vpc_id {
  value       = module.vpc.vpc_id
}

output private_subnets {
  value       = module.vpc.private_subnets
}
