package cch.metrics.resource_inventory_enabled

import data.cch.compare
import rego.v1

default applicable = false

default compliant = false

enabled := input.resourceInventory.enabled

applicable if {
	input.type[_] == "ResourceInventory"
}

compliant if {
	compare(data.operator, data.target_value, enabled)
}
