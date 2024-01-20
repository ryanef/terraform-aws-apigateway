resource "aws_iam_role" "cw_api_role" {
  name = "cwapi_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "CWAPIGW"
        Principal = {
          Service = "apigateway.amazonaws.com"
        }
      },
    ]
  })
}
resource "aws_iam_role_policy" "cw_api_policy" {
  name = "cwapipolicy"
  role = aws_iam_role.cw_api_role.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}