terraform {
  backend "s3" {
    bucket         = "suman-tf-state-test-s3" #version controlled remote backend
    key            = "network/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "suman-tf-state-test-lock"  # DynamoDB table for state locking
    encrypt        = true                    # optional, encrypt state in S3
  }
}
