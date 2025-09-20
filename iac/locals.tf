# store the parsed secret value in a local variable for easier reference
locals {
  secrets = jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)
  ecr_registry_trimmed = trimspace(replace(local.secrets.ecr_registry, "https://", ""))
  ecr_registry_clean = endswith(local.ecr_registry_trimmed, "/") ? substr(local.ecr_registry_trimmed, 0, length(local.ecr_registry_trimmed) - 1) : local.ecr_registry_trimmed
}
