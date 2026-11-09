package cch.metrics.device_checklist_coverage

import data.cch.all_compliant
import data.cch.comparison_result
import input.deviceManagementPolicy as deviceManagementPolicy
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"mandatedControlsCount" in object.keys(deviceManagementPolicy)
	"PolicyDocument" in input.type
}

compliant if {
	all_compliant(results)
}

message := "All of the mandated 7-point device checklist is explicitly present." if {
	compliant
} else := "Not all of the mandated 7-point device checklist is explicitly present." if {
	not compliant
}

results := [comparison_result("deviceManagementPolicy.mandatedControlsCount", deviceManagementPolicy.mandatedControlsCount)]
