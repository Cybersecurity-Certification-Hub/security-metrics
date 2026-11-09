package cch.metrics.monitoring_review_frequency

import data.cch.all_compliant
import data.cch.comparison_result
import input.monitoringProcedure as monitoringProcedure
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"intervalMonths" in object.keys(input.monitoringProcedure)
	"PolicyDocument" in input.type
}

compliant if {
	all_compliant(results)
}

message := "Monitoring procedures are reviewed frequently enough to ensure compliance." if {
	compliant
} else := "Monitoring procedures are not reviewed frequently enough to ensure compliance. Review frequency should be within the specified interval." if {
	not compliant
}

results := [comparison_result("monitoringProcedure.intervalMonths", monitoringProcedure.intervalMonths)]
