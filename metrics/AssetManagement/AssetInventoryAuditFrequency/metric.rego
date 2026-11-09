package cch.metrics.asset_inventory_audit_frequency

import data.cch.all_compliant
import data.cch.comparison_result
import input as document
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"auditInterval" in object.keys(input.assetInventory)
	"PolicyDocument" in document.type
}

compliant if {
	all_compliant(results)
}

message := "Asset inventory audits are performed frequently enough." if {
	compliant
} else := "Asset inventory audits are not performed frequently enough. Audit frequency should be within the specified interval." if {
	not compliant
}

results := [comparison_result("assetInventory.auditInterval", document.assetInventory.auditInterval)]
