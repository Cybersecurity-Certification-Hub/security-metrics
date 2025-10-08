package cch.metrics.key_rotation_frequency

import data.cch.compare
import rego.v1

# Expose the key rotation payload so we can support multiple evidence formats.
key_rotation := payload if {
    payload := object.get(input, "keyRotation", null)
    payload != null
}

default applicable = false

default compliant = false

applicable if {
    key_rotation
}

compliant if {
    days := key_rotation_frequency_days
    compare(data.operator, data.target_value, days)
}

key_rotation_frequency_days := days if {
    rotation := key_rotation
    value := object.get(rotation, "rotationFrequencyDays", null)
    value != null
    days = to_number(value)
} else := days if {
    rotation := key_rotation
    value := object.get(rotation, "rotationFrequencyHours", null)
    value != null
    hours := to_number(value)
    days = hours / 24
} else := days if {
    rotation := key_rotation
    value := object.get(rotation, "rotationFrequencySeconds", null)
    value != null
    seconds := to_number(value)
    days = seconds / 86400
} else := days if {
    rotation := key_rotation
    value := object.get(rotation, "rotationFrequency", null)
    value != null
    duration_ns := time.parse_duration_ns(value)
    days = duration_ns / (((1000 * 1000) * 1000) * 3600 * 24)
} else := days if {
    rotation := key_rotation
    value := object.get(rotation, "rotationInterval", null)
    value != null
    duration_ns := time.parse_duration_ns(value)
    days = duration_ns / (((1000 * 1000) * 1000) * 3600 * 24)
}
