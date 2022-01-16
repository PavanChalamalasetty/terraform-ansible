output "IMAGE_BUCKET_NAME" {
  value = aws_s3_bucket.image-artifacts.id
}
output "IMAGE_BUCKET_REGION" {
    value = aws_s3_bucket.image-artifacts.region
}
output "IMAGE_BUCKET_ACCESS_KEY" {
    value = aws_iam_access_key.s3user.id
}
output "IMAGE_BUCKET_SECRET_KEY" {
    value = aws_iam_access_key.s3user.secret
}