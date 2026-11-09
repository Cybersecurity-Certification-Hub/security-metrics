package cch.metrics.subcontractor_monitoring_cadence_defined

import data.cch.all_compliant
import data.cch.comparison_result
import input.outsourcingPolicy as outsourcingPolicy
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"monitoringMechanism" in object.keys(outsourcingPolicy)
	"PolicyDocument" in input.type
}

compliant if {
	all_compliant(results)
}

message := "The addendum defines a monitoring cadence or mechanism for subcontractor compliance." if {
	compliant
} else := "The addendum does not define a monitoring cadence or mechanism for subcontractor compliance." if {
	not compliant
}

results := [comparison_result("outsourcingPolicy.monitoringMechanism", outsourcingPolicy.monitoringMechanism)]
