package cch.metrics.software_attestation_enabled

import data.cch.compare
import rego.v1
import input.softwareAttestations as sa

default applicable = false

default compliant = false

applicable if {
    sa != {}
    "Application" in input.type
}

compliant if {
    # Checks if every element in the list of softwareAttestations has the property enabled set correctly
    every elem in sa {
		compare(data.operator, data.target_value, elem.enabled)
	}
}
