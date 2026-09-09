package cch.metrics.asset_inventory_defined

import data.cch.compare
import rego.v1
import input as document

default applicable := false

default compliant := false

applicable if {
	document != {}
	"PolicyDocument" in document.type
	document.assetInventory
}

compliant if {
	compare(data.operator, data.target_value, document.assetInventory.inventoryDefined)
}
