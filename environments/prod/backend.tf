terraform {
  required_version = ">= 1.11"

  backend "s3" {
    bucket       = "suman-tf-state-prod"
    key          = "eks/terraform.tfstate"
    region       = "eu-west-1"
    encrypt      = true
    use_lockfile = true
  }
}

