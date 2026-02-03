package cch.metrics.asset_inventory_status_management_q3

import data.cch.compare
import rego.v1
import input as document

default applicable := false

default compliant := false

applicable if {
    "PolicyDocument" in document.type
}

compliant if {
    compare(data.operator, data.target_value, document.AssetInventory.AssetStatus.updateInterval)
}

message := "Asset status changes are recorded within the required timeframe." if {
  compliant
} else := "Asset status changes are not recorded within the required timeframe. Update interval should be within the specified period." if {
  not compliant
}
