package cch.metrics.asset_inventory_audit_frequency

import data.cch.compare
import rego.v1
import input.assetInventory as ai

default applicable := false
default compliant := false

applicable if {
    "PolicyDocument" in input.type
}

compliant if {
  compare(data.operator, data.target_value, ai.auditInterval)
}

message := "Asset inventory audits are performed frequently enough." if {
  compliant
} else := "Asset inventory audits are not performed frequently enough. Audit frequency should be within the specified interval." if {
  not compliant
}