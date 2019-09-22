data "aws_iam_policy_document" "static_hosting_via_bucket_policy" {

  statement {
    actions = [
      "s3:GetObject",
      ]

    resources = [
      "arn:aws:s3:::${var.domain}/*",
      ]

    sid = "AddPerm"

    principals {
      type = "*"
      identifiers = ["*"]
    }

    effect = "Allow"
  }
}


resource "aws_s3_bucket" "web_content" {

  bucket = var.domain
  acl = "public-read"
  policy = data.aws_iam_policy_document.static_hosting_via_bucket_policy.json

  website {

    index_document = "index.html"
    error_document = "404.html"
  }

  force_destroy = true

}

