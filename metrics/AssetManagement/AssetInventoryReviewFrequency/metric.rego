package cch.metrics.asset_inventory_review_frequency

import data.cch.all_compliant
import data.cch.comparison_result
import input.assetInventory as assetInventory
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"reviewFrequency" in object.keys(input.assetInventory)
	"PolicyDocument" in input.type
}

compliant if {
	all_compliant(results)
}

message := "The policy document defines the asset inventory review frequency." if {
	compliant
} else := "The policy document does not define the asset inventory review frequency within the specified interval." if {
	not compliant
}

results := [comparison_result("assetInventory.reviewFrequency", assetInventory.reviewFrequency)]
