package cch.metrics.asset_inventory_status

import data.cch.comparison_result
import rego.v1
import input.assetInventory as ai

default applicable := false

default compliant := false

applicable if {
  input.assetInventory.status
  "PolicyDocument" in input.type
}

compliant if {
	every r in results { r.success }
}

message := "Asset status options are properly defined." if {
  compliant
} else := "Asset status options are not properly defined. Status options should match the specified values." if {
  not compliant
}

results := [comparison_result("assetInventory.status", ai.status)]
