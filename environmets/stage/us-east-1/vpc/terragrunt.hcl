terraform { 
  source = "../../../../modules/vpc" 
}
inputs = { 
  cidr     = "10.0.0.0/16"
  vpc_name = "forestoken-vpc-production" 
}

include { 
  path = find_in_parent_folders() 
}
