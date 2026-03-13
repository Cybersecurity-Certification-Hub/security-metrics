package cch.metrics.asset_inventory_update_frequency

import data.cch.compare
import rego.v1
import input as document

default applicable := false

default compliant := false

applicable if {
    "PolicyDocument" in document.type
}

compliant if {
    compare(data.operator, data.target_value, document.assetInventory.updateInterval)
}

message := "Asset inventory is updated frequently enough." if {
  compliant
} else := "Asset inventory is not updated frequently enough. Inventory update frequency should be within the specified interval." if {
  not compliant
}
