package cch.metrics.asset_inventory_storage_check_q1

import data.cch.compare
import rego.v1
import input as document

default applicable := false

default compliant := false

applicable if {
    "PolicyDocument" in document.type
}

compliant if {
    compare(data.operator, data.target_value, document.AssetInventory.storage)
}

message := "Asset records are stored in an appropriate facility type." if {
  compliant
} else := "Asset records are not stored in an appropriate facility type. Storage type should be one of the specified options." if {
  not compliant
}
