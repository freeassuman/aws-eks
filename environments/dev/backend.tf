terraform {
  backend "s3" {
    bucket         = "suman-tf-state-dev-s3" #version controlled remote backend
    key            = "eks/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "suman-tf-state-dev-lock"  # DynamoDB table for state locking
    encrypt        = true                    # optional, encrypt state in S3
  }
}
