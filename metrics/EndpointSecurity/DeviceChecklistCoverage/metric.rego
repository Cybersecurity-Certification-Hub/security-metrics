package cch.metrics.device_checklist_coverage

import data.cch.comparison_result
import rego.v1
import input.deviceManagementPolicy as deviceManagementPolicy

default applicable := false
default compliant := false

applicable if {
	"checklistCoveragePercent" in object.keys(deviceManagementPolicy)
	is_number(deviceManagementPolicy.checklistCoveragePercent)
	"PolicyDocument" in input.type
}

compliant if {
	every r in results { r.success }
}

message := "All of the mandated 7-point device checklist is explicitly present." if {
	compliant
} else := "Not all of the mandated 7-point device checklist is explicitly present." if {
	not compliant
}

results := [comparison_result("deviceManagementPolicy.checklistCoveragePercent", deviceManagementPolicy.checklistCoveragePercent)]
