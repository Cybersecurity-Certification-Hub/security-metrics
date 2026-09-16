package cch.metrics.asset_inventory_defined

import data.cch.comparison_result
import rego.v1
import input.assetInventory as assetInventory

default applicable := false
default compliant := false

applicable if {
      assetInventory != {}
      "PolicyDocument" in input.type
}

compliant if {
      every r in results { r.success }
}

results := [comparison_result("assetInventory.inventoryDefined", assetInventory.inventoryDefined)]
