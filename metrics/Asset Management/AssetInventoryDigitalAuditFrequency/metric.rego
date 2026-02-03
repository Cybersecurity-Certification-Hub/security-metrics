package cch.metrics.asset_inventory_digital_q6

import data.cch.compare
import rego.v1
import input as document

default applicable := false

default compliant := false

applicable if {
    "PolicyDocument" in document.type
}

compliant if {
    compare(data.operator, data.target_value, document.assetInventory.digital.auditInterval)
}

message := "Digital asset security audits are performed frequently enough." if {
  compliant
} else := "Digital asset security audits are not performed frequently enough. Audit frequency should be within the specified interval." if {
  not compliant
}
