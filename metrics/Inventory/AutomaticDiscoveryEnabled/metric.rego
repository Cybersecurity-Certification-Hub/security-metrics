package cch.metrics.automatic_discovery_enabled

import data.cch.compare
import rego.v1

default applicable = false

default compliant = false

enabled := input.resourceInventory.automaticDiscoveryEnabled

applicable if {
	input.type[_] == "ResourceInventory"
}

compliant if {
	compare(data.operator, data.target_value, enabled)
}
