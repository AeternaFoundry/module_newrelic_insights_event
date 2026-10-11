variable "insights_events" {
  description = <<EOT
Map of insights_events, attributes below
Required:
    - event (block):
        - attribute (required, block):
            - key (required)
            - type (optional)
            - value (required)
        - timestamp (optional)
        - type (required)
EOT

  type = map(object({
    event = list(object({
      attribute = list(object({
        key   = string
        type  = optional(string)
        value = string
      }))
      timestamp = optional(number)
      type      = string
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.insights_events : (
        length(v.event) >= 1
      )
    ])
    error_message = "Each event list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.insights_events : (
        alltrue([for item in v.event : (length(item.attribute) >= 1 && length(item.attribute) <= 255)])
      )
    ])
    error_message = "Each attribute list must contain between 1 and 255 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.insights_events : (
        alltrue([for item in v.event : (can(regex("^[a-zA-Z0-9_: ]+$", item.type)))])
      )
    ])
    error_message = "only alphanumeric characters, underscores, and colons allowed for event type"
  }
  validation {
    condition = alltrue([
      for k, v in var.insights_events : (
        alltrue([for item in v.event : (alltrue([for item in item.attribute : (length(item.key) >= 1 && length(item.key) <= 255)]))])
      )
    ])
    error_message = "must be between 1 and 255 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.insights_events : (
        alltrue([for item in v.event : (alltrue([for item in item.attribute : (item.type == null || (contains([for v in ["", "int", "float", "string"] : lower(v)], lower(item.type))))]))])
      )
    ])
    error_message = "must be one of: \"\", \"int\", \"float\", \"string\""
  }
}

