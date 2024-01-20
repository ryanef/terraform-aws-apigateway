output "stage_invoke_url" {
  value = aws_api_gateway_stage.stage.invoke_url
}

output "apigw_arn" {
  value = aws_api_gateway_rest_api.rest.arn
}