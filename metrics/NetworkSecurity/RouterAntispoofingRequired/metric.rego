package cch.metrics.router_antispoofing_required

import data.cch.all_compliant
import data.cch.comparison_result
import input.networkThreatMitigationPolicy as networkThreatMitigationPolicy
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"antispoofingRequired" in object.keys(networkThreatMitigationPolicy)
	"PolicyDocument" in input.type
}

compliant if {
	all_compliant(results)
}

message := "The standard explicitly requires antispoofing mechanisms on internet-facing routers." if {
	compliant
} else := "The standard does not explicitly require antispoofing mechanisms on internet-facing routers." if {
	not compliant
}

results := [comparison_result("networkThreatMitigationPolicy.antispoofingRequired", networkThreatMitigationPolicy.antispoofingRequired)]
