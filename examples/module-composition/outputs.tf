output "application_bucket" {
  description = "Application bucket details"
  value = {
    id   = module.application_bucket.bucket_id
    arn  = module.application_bucket.bucket_arn
    name = module.application_bucket.bucket_domain_name
  }
}

output "logs_bucket" {
  description = "Logs bucket details"
  value = {
    id   = module.logs_bucket.bucket_id
    arn  = module.logs_bucket.bucket_arn
    name = module.logs_bucket.bucket_domain_name
  }
}

output "all_buckets" {
  description = "Map of all bucket IDs"
  value       = local.bucket_info
}
