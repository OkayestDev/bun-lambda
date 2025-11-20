resource "null_resource" "template_dockerfile" {
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = <<EOF
        bun ${path.module}/template-dockerfile.js ${var.code_path} ${var.package_json_path} ${var.bun_lock_path} ${var.lambda_function_handler} ${var.image_name} ${var.compile_code ? "true" : "false"}
    EOF
  }
}

resource "null_resource" "docker_login" {
  depends_on = [
    null_resource.template_dockerfile
  ]

  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = <<EOF
        aws ${var.aws_profile != null ? "--profile ${var.aws_profile}" : ""} ecr get-login-password --region ${var.aws_region} | docker login --username AWS --password-stdin ${aws_ecr_repository.ecr.repository_url}
    EOF
  }
}

resource "null_resource" "docker_build" {
  depends_on = [
    null_resource.docker_login
  ]

  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = <<EOF
        docker build -t ${var.image_name}:${var.image_tag} -f ${path.module}/${var.image_name}.Dockerfile ..
    EOF
  }
}

resource "null_resource" "docker_tag" {
  depends_on = [
    null_resource.docker_build
  ]

  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = <<EOF
        docker tag ${var.image_name}:${var.image_tag} ${aws_ecr_repository.ecr.repository_url}:${var.image_tag}
    EOF
  }
}

resource "null_resource" "docker_push" {
  depends_on = [
    null_resource.docker_tag
  ]

  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = <<EOF
        docker push ${aws_ecr_repository.ecr.repository_url}:${var.image_tag}
    EOF
  }
}
