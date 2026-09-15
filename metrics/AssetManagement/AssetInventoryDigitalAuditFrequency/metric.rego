package cch.metrics.asset_inventory_digital_audit_frequency

import data.cch.comparison_result
import rego.v1
import input.assetInventory as ai

default applicable := false

default compliant := false

applicable if {
  ai != {}
  "PolicyDocument" in input.type
  ai.type == "digital"
  ai.auditInterval != {}
  ai.auditInterval != null
}

compliant if {
	every r in results { r.success }
}

message := "Digital asset security audits are performed frequently enough." if {
  compliant
} else := "Digital asset security audits are not performed frequently enough. Audit frequency should be within the specified interval." if {
  not compliant
}

results := [comparison_result("assetInventory.auditInterval", ai.auditInterval)]
