package cch.metrics.asset_inventory_update_frequency

import data.cch.all_compliant
import data.cch.comparison_result
import input.assetInventory as assetInventory
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"updateInterval" in object.keys(input.assetInventory)
	"PolicyDocument" in input.type
}

compliant if {
	all_compliant(results)
}

message := "Asset inventory is updated frequently enough." if {
	compliant
} else := "Asset inventory is not updated frequently enough. Inventory update frequency should be within the specified interval." if {
	not compliant
}

results := [comparison_result("assetInventory.updateInterval", assetInventory.updateInterval)]
