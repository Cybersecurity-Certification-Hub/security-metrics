package cch.metrics.subcontractor_monitoring_cadence_defined

import data.cch.comparison_result
import rego.v1
import input.outsourcingPolicy as outsourcingPolicy

default applicable := false
default compliant := false

applicable if {
	"monitoringMechanism" in object.keys(outsourcingPolicy)
	"PolicyDocument" in input.type
}

compliant if {
	every r in results { r.success }
}

message := "The addendum defines a monitoring cadence or mechanism for subcontractor compliance." if {
	compliant
} else := "The addendum does not define a monitoring cadence or mechanism for subcontractor compliance." if {
	not compliant
}

results := [comparison_result("outsourcingPolicy.monitoringMechanism", outsourcingPolicy.monitoringMechanism)]
