data "aws_iam_policy_document" "api_invoke" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions   = ["execute-api:Invoke"]
    resources = [aws_api_gateway_rest_api.rest.execution_arn]

    # condition {
    #   test     = "IpAddress"
    #   variable = "aws:SourceIp"
    #   values   = ["123.123.123.123/32"]
    # }
  }
}
