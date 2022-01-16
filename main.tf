## Import Required Providers 
provider "aws" {
  region = var.aws_region
}
## Create s3 bucket
resource "aws_s3_bucket" "image-artifacts" {
  bucket_prefix = var.bucket_prefix
  acl = var.acl
  
   versioning {
    enabled = var.versioning
  }
  
  tags = var.tags
}
## Create IAM user 
resource "aws_iam_user" "s3user" {
  name = "iam-user"
  path = "/system/"

  tags = var.tags
}
## Creates an Access Key and Secret Key and runs a playbook
resource "aws_iam_access_key" "s3user" {
  user = aws_iam_user.s3user.name
  provisioner "local-exec" {
    command = "sleep 100"
  }
  provisioner "local-exec" {
    command = "ansible-playbook playbook.yml"
  }
}

## Creates an IAM user policy
resource "aws_iam_user_policy" "s3user_rw" {
  name = "s3user_rw_policy"
  user = aws_iam_user.s3user.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:DeleteObject"
      ],
      "Effect": "Allow",
      "Resource": ["arn:aws:s3:::us-west-2-bucket-image-artifacts/*"]
    }
  ]
}
EOF
}
