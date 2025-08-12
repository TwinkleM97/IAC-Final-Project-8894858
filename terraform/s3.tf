resource "random_id" "suffix" {
  byte_length = 2
}

locals {
  base        = lower(replace("${var.student_alias}-${var.student_id}", "_", "-"))
  bucket_keys = ["logs", "data", "assets", "backups"] # fixed keys => plan-time known
}

resource "aws_s3_bucket" "b" {
  for_each      = toset(local.bucket_keys)
  bucket        = "${local.base}-tf-${each.key}-${random_id.suffix.hex}"
  force_destroy = true
  tags = {
    Project = "PROG8870"
    Owner   = var.student_alias
  }
}

resource "aws_s3_bucket_public_access_block" "pab" {
  for_each                = aws_s3_bucket.b
  bucket                  = each.value.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "v" {
  for_each = aws_s3_bucket.b
  bucket   = each.value.id
  versioning_configuration {
    status = var.enable_bucket_versioning ? "Enabled" : "Suspended"
  }
}
