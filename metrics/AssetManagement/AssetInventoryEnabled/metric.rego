package cch.metrics.asset_inventory_enabled

import data.cch.comparison_result
import rego.v1
import input as document

default applicable := false
default compliant := false

applicable if {
	document != {}
	document.assetInventory
	"PolicyDocument" in document.type
	document.assetInventory.service != {}
	document.assetInventory.service != null
}

compliant if {
	every r in results { r.success }
}

message := "The policy document defines an enabled asset inventory cloud feature." if {
	compliant
} else := "The policy document does not define an enabled asset inventory cloud feature." if {
	not compliant
}

results := [comparison_result("assetInventory.service", document.assetInventory.service)]
