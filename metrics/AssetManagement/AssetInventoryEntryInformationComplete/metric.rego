package cch.metrics.asset_inventory_entry_information_complete

import data.cch.compare
import rego.v1
import input as am

default applicable := false

default compliant := false

applicable if {
    "AssetManagement" in asset_management.type
}

compliant if {
    compare(data.operator, data.target_value, am.Inventory.entry.allRequiredInformationRecorded)
}
