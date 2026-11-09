package cch.metrics.asset_inventory_enabled

import data.cch.all_compliant
import data.cch.comparison_result
import input.assetInventory as assetInventory
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"service" in object.keys(input.assetInventory)

	"PolicyDocument" in input.type
}

compliant if {
	all_compliant(results)
}

message := "The policy document defines an enabled asset inventory cloud feature." if {
	compliant
} else := "The policy document does not define an enabled asset inventory cloud feature." if {
	not compliant
}

results := [comparison_result("assetInventory.service", assetInventory.service)]
