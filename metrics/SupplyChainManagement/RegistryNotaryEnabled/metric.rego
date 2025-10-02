package cch.metrics.registry_notary_enabled

import data.cch.compare
import rego.v1
import input.containerRegistry as registry

default applicable = false

default compliant = false

applicable if {
    registry
}

compliant if {
    compare(data.operator, data.target_value, registry.contentTrustEnabled)
}
