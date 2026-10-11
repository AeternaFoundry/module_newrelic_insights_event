resource "newrelic_insights_event" "insights_events" {
  for_each = var.insights_events


  dynamic "event" {
    for_each = each.value.event
    content {
      dynamic "attribute" {
        for_each = event.value.attribute
        content {
          key   = attribute.value.key
          type  = attribute.value.type
          value = attribute.value.value
        }
      }
      timestamp = event.value.timestamp
      type      = event.value.type
    }
  }
}

