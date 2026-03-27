package cch.metrics.asset_inventory_status_options

import data.cch.compare
import rego.v1
import input as document

default applicable := false

default compliant := false

applicable if {
    "PolicyDocument" in document.type
}

compliant if {
    compare(data.operator, data.target_value, document.assetInventory.assetStatus.statusOption)
}

message := "Asset status options are properly defined." if {
  compliant
} else := "Asset status options are not properly defined. Status options should match the specified values." if {
  not compliant
}
