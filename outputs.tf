output "insights_events_id" {
  description = "Map of id values across all insights_events, keyed the same as var.insights_events"
  value       = { for k, v in newrelic_insights_event.insights_events : k => v.id }
}
output "insights_events_event" {
  description = "Map of event values across all insights_events, keyed the same as var.insights_events"
  value       = { for k, v in newrelic_insights_event.insights_events : k => v.event }
}

