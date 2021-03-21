#-----------------------------------------------------------
# newrelic_dashboard outputs
#-----------------------------------------------------------

output "dashboard_url" {
  description = "The URL for viewing the dashboard."
  value       = newrelic_dashboard.dashboard.*.dashboard_url
}