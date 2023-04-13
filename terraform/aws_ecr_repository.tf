resource aws_ecr_repository default {
  name                 = local.name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

# data aws_ecr_image default {
#   depends_on = [
#     aws_ecr_repository.default
#   ]
#   repository_name = aws_ecr_repository.default.id
#   image_tag       = "latest"
# }
