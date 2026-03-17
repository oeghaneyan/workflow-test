# Required environment variable - must be set before running Terraform commands
# Usage: export TF_VAR_environment=dev (or set in CI/CD as environment variable)
# Similar to AWS credentials: export AWS_ACCESS_KEY_ID=xxx
# Terraform automatically reads environment variables prefixed with TF_VAR_
variable "environment" {
  description = "Environment name (e.g., dev, staging, prod). This variable is required and must be set as an environment variable using TF_VAR_environment. Has no default value."
  type        = string
  # No default value - this will cause runs to fail if not provided
}
