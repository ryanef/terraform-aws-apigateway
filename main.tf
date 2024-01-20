resource "aws_api_gateway_rest_api" "rest" {
  name = var.apigw_name

  body = file("${path.cwd}/${var.openapi_filename}")
  endpoint_configuration {
    types = var.endpoint_configuration_types
  }
}

resource "aws_api_gateway_deployment" "deployment" {
  rest_api_id = aws_api_gateway_rest_api.rest.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.rest.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "stage" {
  deployment_id = aws_api_gateway_deployment.deployment.id
  rest_api_id   = aws_api_gateway_rest_api.rest.id
  stage_name    = var.stage_name
  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.apigw.arn
    format = "$context.requestId"
  }
  depends_on = [ aws_cloudwatch_log_group.apigw ]
}

resource "aws_cloudwatch_log_group" "apigw" {
  name = "${var.apigw_name}-${var.stage_name}"

  tags = {
    Environment = var.stage_name
  }
}
resource "aws_api_gateway_account" "api" {
  cloudwatch_role_arn = aws_iam_role.cw_api_role.arn
}

