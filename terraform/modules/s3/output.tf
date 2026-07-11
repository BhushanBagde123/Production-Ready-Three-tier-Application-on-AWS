output "bucket_name" {
  value = aws_s3_bucket.config_bucket.bucket
}

output "bucket_id" {
  value = aws_s3_bucket.config_bucket.id
}

output "bucket_arn" {
  value = aws_s3_bucket.config_bucket.arn
}