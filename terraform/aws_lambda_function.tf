resource "aws_lambda_function" "default" {
  function_name = local.name
  image_uri = "${aws_ecr_repository.default.repository_url}:latest"
  depends_on = [aws_ecr_repository.default]
  role = aws_iam_role.default.arn
  package_type = "Image"
}
