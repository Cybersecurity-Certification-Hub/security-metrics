package cch.metrics.asset_inventory_audit_frequency

import data.cch.comparison_result
import rego.v1
import input as document

default applicable := false
default compliant := false

applicable if {
  "auditInterval" in object.keys(input.assetInventory)
  "PolicyDocument" in document.type
}

compliant if {
	every r in results { r.success }
}

message := "Asset inventory audits are performed frequently enough." if {
  compliant
} else := "Asset inventory audits are not performed frequently enough. Audit frequency should be within the specified interval." if {
  not compliant
}

results := [comparison_result("assetInventory.auditInterval", document.assetInventory.auditInterval)]
