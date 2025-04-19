locals {
  files = [
    for file in fileset("./html-web-app", "*") : file
  ]
}

resource "aws_s3_bucket_object" "files" {
  for_each = toset(local.files)

  bucket = aws_s3_bucket.app_bucket.id
  key    = each.value
  source = "./html-web-app/${each.value}"
}