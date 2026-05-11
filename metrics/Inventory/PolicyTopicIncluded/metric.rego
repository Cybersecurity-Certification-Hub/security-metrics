package cch.metrics.policy_topic_included

import data.cch.compare
import rego.v1

default applicable = false

default compliant = false

topic := input.policyDocument.topic

applicable if {
	topic != null
}

compliant if {
	compare(data.operator, data.target_value, topic) 
}