package cch.metrics.asset_inventory_digital_audit_frequency

import data.cch.compare
import rego.v1
import input.assetInventory as ai

default applicable := false

default compliant := false

applicable if {
  ai.type == "digital"
  "auditInterval" in object.keys(ai)
  is_number(ai.auditInterval)
  ai.auditInterval > 0
  "PolicyDocument" in input.type
}


compliant if {
    compare(data.operator, data.target_value, ai.auditInterval)
}

message := "Digital asset security audits are performed frequently enough." if {
  compliant
} else := "Digital asset security audits are not performed frequently enough. Audit frequency should be within the specified interval." if {
  not compliant
}
