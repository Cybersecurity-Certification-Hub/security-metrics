package cch.metrics.asset_inventory_defined

import data.cch.all_compliant
import data.cch.comparison_result
import input.assetInventory as assetInventory
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"inventoryDefined" in object.keys(assetInventory)
	"PolicyDocument" in input.type
}

compliant if {
	all_compliant(results)
}

message := "The policy defines an Asset Inventory." if {
	compliant
} else := "The policy does not define an Asset Inventory." if {
	not compliant
}

results := [comparison_result("assetInventory.inventoryDefined", assetInventory.inventoryDefined)]
