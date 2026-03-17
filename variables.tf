# Required environment variable - must be set before running Terraform commands
# Usage: export TF_VAR_environment=dev (or set in CI/CD as environment variable)
# Similar to AWS credentials: export AWS_ACCESS_KEY_ID=xxx
# Terraform automatically reads environment variables prefixed with TF_VAR_
# This variable is defined in main.tf
