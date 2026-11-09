package cch.metrics.asset_inventory_status

import data.cch.all_compliant
import data.cch.comparison_result
import input.assetInventory as assetInventory
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"status" in object.keys(input.assetInventory)
	"PolicyDocument" in input.type
}

compliant if {
	all_compliant(results)
}

message := "Asset status options are properly defined." if {
	compliant
} else := "Asset status options are not properly defined. Status options should match the specified values." if {
	not compliant
}

results := [comparison_result("assetInventory.status", assetInventory.status)] if applicable
