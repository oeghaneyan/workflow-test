# Terraform Workflow Test Configuration

This Terraform configuration is designed to test Firefly workflows without requiring any cloud provider credentials. It uses only local providers that don't need authentication.

## Resources

The configuration creates:
- **Random resources**: `random_id`, `random_string`, and `random_integer` resources
- **Time delays**: Three `time_sleep` resources, each with a 30-second delay
- **Dependencies**: Resources are organized in layers with dependencies between them

## Resource Structure

1. **Initial Layer** (no dependencies):
   - `random_id.primary`
   - `random_string.name_suffix`
   - `random_integer.port`

2. **First Wait** (30 seconds):
   - `time_sleep.wait_30s_1` depends on initial resources

3. **Second Layer** (depends on first wait):
   - `random_id.secondary`
   - `random_string.app_name`
   - `random_integer.replica_count`

4. **Second Wait** (30 seconds):
   - `time_sleep.wait_30s_2` depends on second layer resources

5. **Third Layer** (depends on second wait):
   - `random_id.tertiary`
   - `random_string.database_name`
   - `random_integer.database_port`
   - `random_string.api_key`

6. **Third Wait** (30 seconds):
   - `time_sleep.wait_30s_3` depends on third layer resources

7. **Final Layer** (depends on third wait):
   - `random_id.final`
   - `random_string.session_token`
   - `random_integer.timeout`

## Required Environment Variable

The configuration requires the `environment` variable to be set as an environment variable. This variable has no default value, so runs will fail if it's not provided.

See `variables.tf.example` for reference on how to set the environment variable.

**You must set it as an environment variable using the `TF_VAR_` prefix:**

```bash
export TF_VAR_environment=dev
```

Or for a single command:
```bash
TF_VAR_environment=dev terraform apply
```

## Usage

```bash
# Set the required environment variable
export TF_VAR_environment=dev

# Initialize Terraform
terraform init

# Plan the deployment
terraform plan

# Apply the configuration
terraform apply

# View outputs
terraform output

# Destroy resources
terraform destroy
```

## Total Execution Time

With three 30-second waits, the total execution time will be approximately **90 seconds** plus the time needed to create the random resources.

## Outputs

The configuration includes comprehensive outputs for all resources, including:
- Individual resource values
- Sensitive outputs (API key, session token)
- Aggregated outputs (all resource IDs, wait status)
