package cch.metrics.mitigated_network_attacks

import data.cch.compare
import rego.v1
import input as document

default applicable := false

default compliant := false

applicable if {
    "PolicyDocument" in document.type
}

compliant if {
    compare(data.operator, data.target_value, document.networkThreatMitigationPolicy.coveredAttackTypes)
}

message := "The policy document defines network threat mitigation mechanisms covering the specified attack types." if {
    compliant
} else := "The policy document does not adequately define mitigated network attack types." if {
    not compliant
}
