package cch.metrics.asset_inventory_entry_information_complete

import data.cch.compare
import rego.v1
import resource.AssetManagement as am

default applicable := false

default compliant := false

applicable if {
    am
}

compliant if {
    compare(data.operator, data.target_value, am.Inventory.Entry.allRequiredInformationRecorded)
}
