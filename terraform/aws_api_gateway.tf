resource "aws_api_gateway_rest_api" "default" {
  name        = local.name
  description = "Djandorless Application"
}

resource "aws_api_gateway_resource" "default" {
  rest_api_id = "${aws_api_gateway_rest_api.default.id}"
  parent_id   = "${aws_api_gateway_rest_api.default.root_resource_id}"
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy" {
  rest_api_id   = "${aws_api_gateway_rest_api.default.id}"
  resource_id   = "${aws_api_gateway_resource.default.id}"
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda" {
  rest_api_id = "${aws_api_gateway_rest_api.default.id}"
  resource_id = "${aws_api_gateway_method.proxy.resource_id}"
  http_method = "${aws_api_gateway_method.proxy.http_method}"

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.default.invoke_arn}"
}

resource "aws_api_gateway_method" "proxy_root" {
  rest_api_id   = "${aws_api_gateway_rest_api.default.id}"
  resource_id   = "${aws_api_gateway_rest_api.default.root_resource_id}"
  http_method   = "ANY"
  authorization = "NONE"
  #authorization = "COGNITO_USER_POOLS"
  #authorizer_id = aws_api_gateway_authorizer.default.id
  #authorization_scopes = ["email"]

  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_integration" "lambda_root" {
  rest_api_id = "${aws_api_gateway_rest_api.default.id}"
  resource_id = "${aws_api_gateway_method.proxy_root.resource_id}"
  http_method = "${aws_api_gateway_method.proxy.http_method}"

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.default.invoke_arn}"
}

resource "aws_api_gateway_deployment" "default" {
  depends_on = [
    aws_api_gateway_integration.lambda,
    aws_api_gateway_integration.lambda_root,
  ]

  rest_api_id = "${aws_api_gateway_rest_api.default.id}"
  stage_name  = "${local.env}"
}

resource "aws_lambda_permission" "default" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.default.function_name}"
  principal     = "apigateway.amazonaws.com"

  # The /*/* portion grants access from any method on any resource
  # within the API Gateway "REST API".
  source_arn = "${aws_api_gateway_rest_api.default.execution_arn}/*/*"
}
