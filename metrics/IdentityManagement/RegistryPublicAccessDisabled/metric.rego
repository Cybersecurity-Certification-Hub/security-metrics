package cch.metrics.registry_public_access_disabled

import data.cch.compare
import rego.v1
import input as registry

default applicable = false

default compliant = false

applicable if {
    registry.type[_] == "ContainerRegistry"
}

compliant if {
    compare(data.operator, data.target_value, registry.publicAccessDisabled)
}
