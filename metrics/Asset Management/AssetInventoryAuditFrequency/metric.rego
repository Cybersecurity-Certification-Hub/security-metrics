package cch.metrics.asset_inventory_audit_frequency_q5

import data.cch.compare
import rego.v1
import input as document

default applicable := false
default compliant := false

applicable if {
    "PolicyDocument" in document.type
}

compliant if {
  compare(data.operator, data.target_value, document.AssetInventory.auditInterval)
}

message := "Asset inventory audits are performed frequently enough." if {
  compliant
} else := "Asset inventory audits are not performed frequently enough. Audit frequency should be within the specified interval." if {
  not compliant
}