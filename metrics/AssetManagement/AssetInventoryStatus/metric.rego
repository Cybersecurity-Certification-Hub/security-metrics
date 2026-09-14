package cch.metrics.asset_inventory_status

import data.cch.compare
import rego.v1
import input.assetInventory as ai

default applicable := false

default compliant := false

applicable if {
  ai != {}
  "PolicyDocument" in input.type
  ai.status != {}
  ai.status != null
}

compliant if {
  compare(data.operator, data.target_value, ai.status)
}

message := "Asset status options are properly defined." if {
  compliant
} else := "Asset status options are not properly defined. Status options should match the specified values." if {
  not compliant
}
