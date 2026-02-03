package cch.metrics.asset_inventory_status_change_update_duration

import data.cch.compare
import rego.v1
import input as document

default applicable := false

default compliant := false

applicable if {
    "PolicyDocument" in document.type
}

compliant if {
    compare(data.operator, data.target_value, document.assetInventory.assetStatus.updateDuration)
}

message := "Asset status changes are recorded within the required timeframe." if {
  compliant
} else := "Asset status changes are not recorded within the required timeframe. Update interval should be within the specified period." if {
  not compliant
}
