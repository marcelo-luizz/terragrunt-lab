terraform { 
  source = "../../../modules/ec2" 
}
inputs = { 
  instance_type = "t2.micro" 
  instance_name = "example-server-homolog" 
  aws_region    = "us-east-1"
}

include { 
  path = find_in_parent_folders() 
}