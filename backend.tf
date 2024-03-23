terraform {
  // local backend
  backend "local" {}

  // aws s3 backend
  # backend "s3" {
  #   bucket = "mybucket"
  #   key    = "path/to/my/key"
  #   region = "us-east-1"
  #   dynamodb_table = "TableName"
  # }
}
