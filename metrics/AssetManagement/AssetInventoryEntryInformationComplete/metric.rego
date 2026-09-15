package cch.metrics.asset_inventory_entry_information_complete

import data.cch.comparison_result
import rego.v1

import input.assetInventory as ai

default applicable := false

default compliant := false

applicable if {
    ai
    ai.allRequiredInformationRecorded != {}
    ai.allRequiredInformationRecorded != null
}

compliant if {
	every r in results { r.success }
}

results := [comparison_result("assetInventory.allRequiredInformationRecorded", ai.allRequiredInformationRecorded)]
