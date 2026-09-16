package cch.metrics.asset_inventory_status_change_update_duration

import data.cch.comparison_result
import rego.v1
import input.assetInventory as ai

default applicable := false

default compliant := false

applicable if {
  ai.updateDuration
  "PolicyDocument" in input.type
}

compliant if {
	every r in results { r.success }
}

message := "Asset status changes are recorded within the required timeframe." if {
  compliant
} else := "Asset status changes are not recorded within the required timeframe. Update interval should be within the specified period." if {
  not compliant
}

results := [comparison_result("assetInventory.updateDuration", ai.updateDuration)]
