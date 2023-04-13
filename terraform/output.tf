output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

#output "base_url" {
  # value = "${aws_api_gateway_deployment.default.invoke_url}/${local.name}"
  # value = aws_lambda_function.default.invoke_arn
#}
