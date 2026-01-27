package cch.metrics.resource_inventory_automatic_discovery_enabled

import data.cch.compare
import rego.v1

default applicable = false

default compliant = false

enabled := input.resourceInventoryService.automaticDiscoveryEnabled

applicable if {
	input.type[_] == "ResourceInventoryService"
}

compliant if {
	compare(data.operator, data.target_value, enabled)
}
