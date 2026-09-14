package cch.metrics.asset_inventory_enabled

import data.cch.compare
import rego.v1
import input.assetInventory as ai

default applicable := false
default compliant := false

applicable if {
    "service" in object.keys(ai)
    is_string(ai.service)
	ai.service != ""
	"PolicyDocument" in input.type
}

compliant if {
	compare(data.operator, data.target_value, ai.service)
}

message := "The policy document defines an enabled asset inventory cloud feature." if {
	compliant
} else := "The policy document does not define an enabled asset inventory cloud feature." if {
	not compliant
}
