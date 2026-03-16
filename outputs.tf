output "primary_id" {
  description = "Primary random ID"
  value       = random_id.primary.hex
}

output "name_suffix" {
  description = "Name suffix string"
  value       = random_string.name_suffix.result
}

output "port" {
  description = "Random port number"
  value       = random_integer.port.result
}

output "secondary_id" {
  description = "Secondary random ID (depends on first wait)"
  value       = random_id.secondary.hex
}

output "app_name" {
  description = "Application name (depends on first wait)"
  value       = random_string.app_name.result
}

output "replica_count" {
  description = "Number of replicas (depends on first wait)"
  value       = random_integer.replica_count.result
}

output "tertiary_id" {
  description = "Tertiary random ID (depends on second wait)"
  value       = random_id.tertiary.hex
}

output "database_name" {
  description = "Database name (depends on second wait)"
  value       = random_string.database_name.result
}

output "database_port" {
  description = "Database port (depends on second wait)"
  value       = random_integer.database_port.result
}

output "api_key" {
  description = "API key (depends on second wait)"
  value       = random_string.api_key.result
  sensitive   = true
}

output "final_id" {
  description = "Final random ID (depends on third wait)"
  value       = random_id.final.hex
}

output "session_token" {
  description = "Session token (depends on third wait)"
  value       = random_string.session_token.result
  sensitive   = true
}

output "timeout" {
  description = "Timeout value in seconds (depends on third wait)"
  value       = random_integer.timeout.result
}

output "all_resource_ids" {
  description = "Map of all resource IDs"
  value = {
    primary   = random_id.primary.hex
    secondary = random_id.secondary.hex
    tertiary  = random_id.tertiary.hex
    final     = random_id.final.hex
  }
}

output "wait_durations" {
  description = "Information about wait resources"
  value = {
    wait_1_completed = time_sleep.wait_30s_1.id != null
    wait_2_completed = time_sleep.wait_30s_2.id != null
    wait_3_completed = time_sleep.wait_30s_3.id != null
  }
}
