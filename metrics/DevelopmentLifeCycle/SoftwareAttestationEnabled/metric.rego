package cch.metrics.software_attestation_enabled

import data.cch.compare
import rego.v1
import input.application as app

default applicable = false

default compliant = false

applicable if {
    app.softwareAttestations != {}
    "Application" in input.type
}

compliant if {
    # Checks if every element in the list of softwareAttestations has the property enabled set correctly
    every elem in app.softwareAttestations {
		compare(data.operator, data.target_value, elem.enabled)
	}
}
