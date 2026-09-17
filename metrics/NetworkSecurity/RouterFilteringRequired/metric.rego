package cch.metrics.router_filtering_required

import data.cch.comparison_result
import rego.v1
import input.networkThreatMitigationPolicy as networkThreatMitigationPolicy

default applicable := false
default compliant := false

applicable if {
	"filteringRequired" in object.keys(networkThreatMitigationPolicy)
	is_boolean(networkThreatMitigationPolicy.filteringRequired)
	"PolicyDocument" in input.type
}

compliant if {
	every r in results { r.success }
}

message := "The standard explicitly requires network filtering on internet-facing routers." if {
	compliant
} else := "The standard does not explicitly require network filtering on internet-facing routers." if {
	not compliant
}

results := [comparison_result("networkThreatMitigationPolicy.filteringRequired", networkThreatMitigationPolicy.filteringRequired)]
