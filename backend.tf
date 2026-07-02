# Remote backend disabled for local state management.
# terraform {
#   backend "s3" {
#     bucket         = "terraform-state-3tier-dev"
#     key            = "three-tier/terraform.tfstate"
#     region         = "ap-south-1"
#     dynamodb_table = "terraform-state-locks"
#     encrypt        = true
#   }
# }
