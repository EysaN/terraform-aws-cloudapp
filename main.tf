terraform {
  backend "remote" {
    organization = "eyxatech"

    workspaces {
      name = "my-cloud-terraform"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
  access_key = "xxxx"
  secret_key = "xxxx" 
}

module "my_app_1" {
    source  = "app.terraform.io/eyxatech/myapp/aws"
    version = "1.0.1"

    # our variables
    app_name = "myapp1"
    env = "dev"
    iam_instance_profile = "AWSEC2ReadOnlyAccess"
    user_data = filebase64("${path.module}/launch_script_1.sh")
    # for the variables which are not defined here, their default values are used
}