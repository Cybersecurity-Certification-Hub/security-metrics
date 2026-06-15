package cch.metrics.asset_inventory_review_frequency

import data.cch.compare
import rego.v1
import input as document

default applicable := false
default compliant := false

applicable if {
	document.assetInventory
	"PolicyDocument" in document.type
}

compliant if {
	compare(data.operator, data.target_value, document.assetInventory.reviewFrequency)
}

message := "The policy document defines the asset inventory review frequency." if {
	compliant
} else := "The policy document does not define the asset inventory review frequency within the specified interval." if {
	not compliant
}
