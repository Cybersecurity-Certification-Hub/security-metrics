package cch.metrics.asset_inventory_defined

import data.cch.comparison_result
import rego.v1
import input.assetInventory as assetInventory

default applicable := false
default compliant := false

applicable if {
	"inventoryDefined" in object.keys(assetInventory)
	"PolicyDocument" in input.type
}

compliant if {
	every r in results { r.success }
}

message := "The policy defines an Asset Inventory." if {
	compliant
} else := "The policy does not define an Asset Inventory." if {
	not compliant
}

results := [comparison_result("assetInventory.inventoryDefined", assetInventory.inventoryDefined)]
