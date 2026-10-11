output "insights_events_id" {
  description = "Map of id values across all insights_events, keyed the same as var.insights_events except keys with no id are omitted"
  value       = { for k, v in newrelic_insights_event.insights_events : k => v.id if v.id != null && length(v.id) > 0 }
}
output "insights_events_event" {
  description = "Map of event values across all insights_events, keyed the same as var.insights_events except keys with no event are omitted"
  value       = { for k, v in newrelic_insights_event.insights_events : k => v.event if v.event != null && length(v.event) > 0 }
}

