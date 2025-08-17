terraform {
  required_version = ">= 1.11"  # ensure support for native S3 locking

  backend "s3" {
    bucket       = "suman-tf-state-test"
    key          = "eks/terraform.tfstate"
    region       = "eu-west-1"
    encrypt      = true
    use_lockfile = true
  }
}
