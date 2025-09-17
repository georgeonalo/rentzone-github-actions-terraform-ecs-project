# store the terraform state file in s3 and lock with dynamodb
terraform {
  backend "s3" {
    bucket         = "georgenal-terraform-remote-state-1"
    key            = "rentzone-app/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-state-lock"
   # profile = "terraform-user"
  }
}
