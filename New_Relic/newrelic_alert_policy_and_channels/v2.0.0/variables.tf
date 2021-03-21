variable "app_name" {
  type        = string
  description = "Name of the alert policy"
}

variable "incident_preference" {
  type        = string
  default     = "PER_CONDITION_AND_TARGET"
  description = "Incident preference for alert policy - PER_POLICY, PER_CONDITION, PER_CONDITION_AND_TARGET. Defaults to PER_CONDITION_AND_TARGET."
}

variable "alert_channel_settings" {
  type = any
  default = {}
}

variable "webhook_payload_type" {
  type    = string
  default = "application/json"
}

variable "webhook_payload_string" {
  default = <<EOF
    {
    "@context": "http://schema.org/extensions",
    "@type": "MessageCard",
    "title": "$EVENT_TYPE: $CONDITION_NAME",
    "text": "$EVENT_TYPE: $CONDITION_ID",
    "sections": [{
            "activityTitle": "Policy: $POLICY_NAME",
            "activitySubtitle": "Status: $EVENT_STATE",
            "activityText": "Severity: $SEVERITY"
        },
        {
            "title": "Details",
                        "text" : "$EVENT_DETAILS",
            "facts": [{
                "name": "Attachments",
                "value": "[Chart]($VIOLATION_CHART_URL)"
            }]
        }
    ],
    "potentialAction": [{
            "@type": "OpenUri",
            "name": "View Incident",
            "targets": [{
                "os": "default",
                "uri": "$INCIDENT_URL"
            }]
        },
        {
            "@type": "OpenUri",
            "name": "Acknoweldge Incident",
            "targets": [{
                "os": "default",
                "uri": "$INCIDENT_ACKNOWLEDGE_URL"
            }]
        },
        {
            "@type": "OpenUri",
            "name": "Runbook",
            "targets": [{
                "os": "default",
                "uri": "$RUNBOOK_URL"
            }]
        }
    ]
}
EOF
}