package cch.metrics.monitoring_review_frequency

import data.cch.comparison_result
import rego.v1
import input.monitoringProcedure as monitoringProcedure

default applicable := false
default compliant := false

applicable if {
	monitoringProcedure != {}
	"PolicyDocument" in input.type
}

compliant if {
	every r in results { r.success }
}

message := "Monitoring procedures are reviewed frequently enough to ensure compliance." if {
	compliant
} else := "Monitoring procedures are not reviewed frequently enough to ensure compliance. Review frequency should be within the specified interval." if {
	not compliant
}

results := [comparison_result("monitoringProcedure.intervalMonths", monitoringProcedure.intervalMonths)]
