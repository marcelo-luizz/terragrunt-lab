terraform { 
  source = "../../../../modules/security_groups" 
}
inputs = { 
  http_port   = "80"
  vpc_id      = dependency.vpc.outputs.vpc_id
  sg_name     = "stage_backend_security_group"

}

dependency "vpc" { 
  config_path = "../vpc" 
}

include { 
  path = find_in_parent_folders() 
}