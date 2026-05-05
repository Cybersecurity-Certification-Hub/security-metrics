package cch.metrics.asset_inventory_entry_information_complete

import data.cch.compare
import rego.v1
import input as assetManagement

default applicable := false

default compliant := false

applicable if {
    "AssetManagement" in assetManagement.type
}

compliant if {
    compare(data.operator, data.target_value, assetManagement.allRequiredInformationRecorded)
}
