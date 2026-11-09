package cch.metrics.asset_inventory_digital_audit_frequency

import data.cch.all_compliant
import data.cch.comparison_result
import input.assetInventory as assetInventory
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"auditInterval" in object.keys(input.assetInventory)
	"PolicyDocument" in input.type
	assetInventory.type == "digital"
}

compliant if {
	all_compliant(results)
}

message := "Digital asset security audits are performed frequently enough." if {
	compliant
} else := "Digital asset security audits are not performed frequently enough. Audit frequency should be within the specified interval." if {
	not compliant
}

results := [comparison_result("assetInventory.auditInterval", assetInventory.auditInterval)]
