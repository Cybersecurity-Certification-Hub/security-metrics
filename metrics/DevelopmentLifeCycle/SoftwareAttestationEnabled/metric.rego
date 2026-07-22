package cch.metrics.software_attestation_enabled

import data.cch.compare
import rego.v1

default applicable = false

default compliant = false

applicable if {
    "Application" in input.type
}

compliant if {
    compare(data.operator, data.target_value, input.softwareAttestations)
}
