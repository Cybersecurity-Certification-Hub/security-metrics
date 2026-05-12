package cch.metrics.asset_inventory_entry_information_complete

import data.cch.compare
import rego.v1

import input.assetInventory as ai

default applicable := false

default compliant := false

applicable if {
    ai.assetInventory
}

compliant if {
    compare(data.operator, data.target_value, ai.allRequiredInformationRecorded)
}
