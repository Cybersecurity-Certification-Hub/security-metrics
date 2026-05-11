package cch.metrics.asset_inventory_audit_frequency

import data.cch.compare
import rego.v1
import input.assetInventory as as

default applicable := false
default compliant := false

applicable if {
    "PolicyDocument" in as.type
    as.type != "digital"
}

compliant if {
  compare(data.operator, data.target_value, as.auditInterval)
}

message := "Asset inventory audits are performed frequently enough." if {
  compliant
} else := "Asset inventory audits are not performed frequently enough. Audit frequency should be within the specified interval." if {
  not compliant
}