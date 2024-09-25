module "s3" {
  source       = "./s3/add_bucket"
  bucket_name  = var.bucket_name
  environment  = var.environment
  project_name = var.environment
}