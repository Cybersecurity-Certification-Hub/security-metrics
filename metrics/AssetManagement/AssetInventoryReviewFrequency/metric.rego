package cch.metrics.asset_inventory_review_frequency

import data.cch.comparison_result
import rego.v1
import input.assetInventory as ai

default applicable := false
default compliant := false

applicable if {
	ai.reviewFrequency
	"PolicyDocument" in input.type
}

compliant if {
	every r in results { r.success }
}

message := "The policy document defines the asset inventory review frequency." if {
	compliant
} else := "The policy document does not define the asset inventory review frequency within the specified interval." if {
	not compliant
}

results := [comparison_result("assetInventory.reviewFrequency", ai.reviewFrequency)]
