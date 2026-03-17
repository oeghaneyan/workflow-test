# Required environment variable - must be set before running Terraform commands
# Usage: export ENVIRONMENT=dev (or set in CI/CD as environment variable)
# Similar to AWS credentials: export AWS_ACCESS_KEY_ID=xxx
# Terraform reads this directly from the ENVIRONMENT environment variable using env() function
# This is defined in main.tf locals block - no variable definition needed
