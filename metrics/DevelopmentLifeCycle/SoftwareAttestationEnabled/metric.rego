package cch.metrics.software_attestation_enabled

import data.cch.comparison_result
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
    every r in results { r.success }
}

results := [comparison_result("softwareAttestations.enabled", elem.enabled) | elem := sa[_]]
