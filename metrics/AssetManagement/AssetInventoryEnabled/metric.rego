package cch.metrics.asset_inventory_enabled

import data.cch.compare
import rego.v1
import input as document

default applicable := false
default compliant := false

applicable if {
	document.cloudFeature
	"PolicyDocument" in document.type
}

compliant if {
	compare(data.operator, data.target_value, document.cloudFeature.property)
}

message := "The policy document defines an enabled asset inventory cloud feature." if {
	compliant
} else := "The policy document does not define an enabled asset inventory cloud feature." if {
	not compliant
}
