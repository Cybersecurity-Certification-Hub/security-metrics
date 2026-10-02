package cch.metrics.router_antispoofing_required

import data.cch.comparison_result
import rego.v1
import input.networkThreatMitigationPolicy as networkThreatMitigationPolicy

default applicable := false
default compliant := false

applicable if {
	"antispoofingRequired" in object.keys(networkThreatMitigationPolicy)
	is_boolean(networkThreatMitigationPolicy.antispoofingRequired)
	"PolicyDocument" in input.type
}

compliant if {
	every r in results { r.success }
}

message := "The standard explicitly requires antispoofing mechanisms on internet-facing routers." if {
	compliant
} else := "The standard does not explicitly require antispoofing mechanisms on internet-facing routers." if {
	not compliant
}

results := [comparison_result("networkThreatMitigationPolicy.antispoofingRequired", networkThreatMitigationPolicy.antispoofingRequired)]
