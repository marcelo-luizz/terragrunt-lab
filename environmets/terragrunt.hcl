locals {
  # Parse the file path we're in to read the env name: e.g., env 
  # will be "dev" in the dev folder, "stage" in the stage folder, 
  # etc.
  parsed = regex(".*/work/(?P<env>.*?)/.*", get_terragrunt_dir())
  env    = local.parsed.env
  folders     = split("/", path_relative_to_include())
  global_vars = yamldecode(file("global.yaml"))
  env_vars    = yamldecode(file(format("%s/%s", local.folders[0], "env.yaml")))
  region_vars = yamldecode(file(format("%s/%s/%s", local.folders[0], local.folders[1], "region.yaml")))
  common_tags = merge(local.global_vars.tags, local.env_vars.tags, local.region_vars.tags)
}

# Configure Provider
generate "provider" {
  path      = "auto_provider.tf"
  if_exists = "overwrite"
  contents  = <<-EOF
    provider "aws" {
      region = "${local.region_vars.aws_region}"
      default_tags {
        tags = {
          ${yamlencode(local.common_tags)}
        }
      } 
    }
  EOF
}

# Configure S3 as a backend
remote_state {
  backend = "s3"
  config = {
    bucket = "example-bucket-${local.env}"
    region = "us-east-1"
    key    = "${path_relative_to_include()}/terraform.tfstate"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}