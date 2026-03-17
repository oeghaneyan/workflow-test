terraform {
  required_version = ">= 1.0"
  
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.9"
    }
  }
}

# Required environment variable - set via TF_VAR_environment (standard Terraform way)
# Usage: export TF_VAR_environment=dev
variable "environment" {
  description = "Environment name (e.g., dev, staging, prod). Set via TF_VAR_environment environment variable."
  type        = string
}

locals {
  environment = var.environment
}

# Random resources - no dependencies
resource "random_id" "primary" {
  byte_length = 8
}

resource "random_string" "name_suffix" {
  length  = 6
  special = false
  upper   = false
}

resource "random_integer" "port" {
  min = 8000
  max = 8999
}

# First wait - 30 seconds
resource "time_sleep" "wait_30s_1" {
  depends_on = [
    random_id.primary,
    random_string.name_suffix
  ]
  
  create_duration = "30s"
}

# Resources that depend on the first wait
resource "random_id" "secondary" {
  depends_on = [time_sleep.wait_30s_1]
  
  byte_length = 12
  keepers = {
    primary_id  = random_id.primary.hex
    environment = local.environment
  }
}

resource "random_string" "app_name" {
  depends_on = [time_sleep.wait_30s_1]
  
  length  = 10
  special = false
  upper   = true
  keepers = {
    suffix      = random_string.name_suffix.result
    environment = local.environment
  }
}

resource "random_integer" "replica_count" {
  depends_on = [time_sleep.wait_30s_1]
  
  min = 1
  max = 5
}

# Second wait - 30 seconds
resource "time_sleep" "wait_30s_2" {
  depends_on = [
    random_id.secondary,
    random_string.app_name,
    random_integer.replica_count
  ]
  
  create_duration = "30s"
}

# Resources that depend on the second wait
resource "random_id" "tertiary" {
  depends_on = [time_sleep.wait_30s_2]
  
  byte_length = 16
  keepers = {
    secondary_id = random_id.secondary.hex
    app_name     = random_string.app_name.result
  }
}

resource "random_string" "database_name" {
  depends_on = [time_sleep.wait_30s_2]
  
  length  = 8
  special = false
  upper   = false
  keepers = {
    app_name    = random_string.app_name.result
    port        = random_integer.port.result
    environment = local.environment
  }
}

resource "random_integer" "database_port" {
  depends_on = [time_sleep.wait_30s_2]
  
  min = 5432
  max = 5439
}

resource "random_string" "api_key" {
  depends_on = [time_sleep.wait_30s_2]
  
  length  = 32
  special = true
  upper   = true
  keepers = {
    secondary_id = random_id.secondary.hex
  }
}

# Third wait - 30 seconds
resource "time_sleep" "wait_30s_3" {
  depends_on = [
    random_id.tertiary,
    random_string.database_name,
    random_integer.database_port,
    random_string.api_key
  ]
  
  create_duration = "30s"
}

# Final resources that depend on the third wait
resource "random_id" "final" {
  depends_on = [time_sleep.wait_30s_3]
  
  byte_length = 20
  keepers = {
    tertiary_id  = random_id.tertiary.hex
    database     = random_string.database_name.result
    api_key_hash = md5(random_string.api_key.result)
  }
}

resource "random_string" "session_token" {
  depends_on = [time_sleep.wait_30s_3]
  
  length  = 64
  special = true
  upper   = true
  keepers = {
    final_id = random_id.final.hex
  }
}

resource "random_integer" "timeout" {
  depends_on = [time_sleep.wait_30s_3]
  
  min = 30
  max = 300
}
