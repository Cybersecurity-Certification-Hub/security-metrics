package cch.metrics.mitigated_network_attacks

import data.cch.comparison_result
import rego.v1
import input.networkThreatMitigationPolicy as networkThreatMitigationPolicy

default applicable := false

default compliant := false

applicable if {
    networkThreatMitigationPolicy != {}
    "PolicyDocument" in input.type
}

compliant if {
	every r in results { r.success }
}

message := "The policy document defines network threat mitigation mechanisms covering the specified attack types." if {
    compliant
} else := "The policy document does not adequately define mitigated network attack types." if {
    not compliant
}

results := [comparison_result("networkThreatMitigationPolicy.coveredAttackTypes", networkThreatMitigationPolicy.coveredAttackTypes)]
