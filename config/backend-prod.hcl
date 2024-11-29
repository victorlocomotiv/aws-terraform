bucket  = "terraform-state-bucket-622482"
key            = "infrastructure/prod/terraform.tfstate"
region         = "us-east-1"
encrypt        = true
dynamodb_table = "terraform-lock"
profile        = "production"