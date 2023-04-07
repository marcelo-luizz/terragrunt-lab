terraform { 
  source = "../../../../modules/ec2" 
}
inputs = { 
  instance_type               = "t2.micro" 
  instance_name               = "example-server-${local.env_vars.env}" 
  aws_region                  = "us-east-1"
  sg_id                       = dependency.security_groups.outputs.sg_id
  subnet_id                   = dependency.vpc.outputs.private_subnets[0]
}

locals {
  env_vars = yamldecode(file(find_in_parent_folders("env.yaml")))
}

include { 
  path = find_in_parent_folders() 
}

dependency "security_groups" { 
  config_path = "../security_groups" 
}

dependency "vpc" { 
  config_path = "../vpc" 
}
