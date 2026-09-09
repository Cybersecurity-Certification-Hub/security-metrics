package cch.metrics.asset_inventory_entry_information_complete

import data.cch.compare
import data.cch.comparison_result
import rego.v1

import input.assetInventory as ai

default applicable := false

default compliant := false

applicable if {
    ai
}

compliant if {
    compare(data.operator, data.target_value, ai.allRequiredInformationRecorded)
}

results := [comparison_result("assetInventory.allRequiredInformationRecorded", ai.allRequiredInformationRecorded)]
